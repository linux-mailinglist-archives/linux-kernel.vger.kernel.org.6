Return-Path: <linux-kernel+bounces-425741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A3D9DEA0D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D627F28176C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 15:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C41C19D898;
	Fri, 29 Nov 2024 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjFXEHjh"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F74D1547FF;
	Fri, 29 Nov 2024 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732895942; cv=none; b=ZVxDw1i4Bt0KiaMNYy12FqqwXLu4e9r7+sgFDd4uAgL+JAyEIFK1clnpwOzQxONlbExBxhmKgDP0lZc3zECUiudoQuLfBy8ph3vLOIqWgEUnJ8XFnYiipiSdjgvEAVqQZROsiaOpWNclSjm7p44jDTNGmOA4+0jSLFa9cHubFM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732895942; c=relaxed/simple;
	bh=NkRH/nCEAwZBq0GsFxUHM8W07UD0cWEPAw9V8E1cKmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHF76P9a77HgwUv/kCaf/p7LYAwjfkcGnEUqOGWRN/9tG+xHrzQe631dJXiU7usu+xQttyFZvlB8Alc2Fg5yYtrjnFajn5wvV5MuPiT06zsbeAExmMShxsYeEOPGVwQnORVDCjyHquXaWp+eKlJ3HbEYB10Q+QCosiZvmlDO8dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjFXEHjh; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-71d579bb207so766926a34.2;
        Fri, 29 Nov 2024 07:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732895940; x=1733500740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isbZ4tT6S+nqvZREZim9rIia4ZQyD95Anv4/kZ2I3bo=;
        b=ZjFXEHjh6BLdNxBO+KjYX0OnU5iBU3vZjvs7AOU/POkkRGZyvTz3f/Vtizi1r3PhrG
         Z87F5W6Oi6haMdl5z/MPFLz0cwpfChiqDQ1byWaefSxMCVxOsWN9dYJx19NCy2iqCUhw
         abZoJYBSb0DU7l3TWvQLR1GgoVTrhITKwhbhoFy2dlMx2U7D+Q0Dv7FAzDJmVqJJjuj2
         zfd6eHVfUJiUV5ogeqaQLIBE4zbCPzRc+7LWlJSZtbqONCrUfkr598DIU6d1h3aN5xpF
         rataYDMkFBVAD7tcHOh6O2WQDch7VTefE5O1h8SSq5X2NXcgokhJWuYiUOPVs6SYJZDz
         yhng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732895940; x=1733500740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isbZ4tT6S+nqvZREZim9rIia4ZQyD95Anv4/kZ2I3bo=;
        b=V5WAlb/jwa1w/F1MXDjrkq2JxEZDO2NDTy09ZMXYkt9/09ypVGQE7MggJNMlsUGxPD
         CwR7FnnGGGrdS2C8iq9XCrO7GOLY8adzWsddSP7k9kt1rZFG3UOpM8+3/WNPudBe52W6
         mi2pJx+PFntn2HizjTYOMtbwtaculy8LzKlnnN8qu4TaInnsxiGgrLXj1cEDH1pEtewS
         PPlP02VNsiCY2pHLfcGKno7xwP0BcTVW5arKcuBc4LUmeDSsIRirpVbXmiV8RaL835vK
         s2UAW9LE0/8f3xbOJOkNGzcfZTJb/Ppd6mmS3Fc2ZFexORclELTxFJmLAC+YhQ63FkHU
         2Eeg==
X-Forwarded-Encrypted: i=1; AJvYcCWwUp0A/qrDsYoStj5qJGSrQLFMmnZfa+qYHLYs1CBm/elfWDXLdZn6vqSoDFnAhNv7kzDyIs5UAbFOoIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWvuPct6wHhhg0Nuq27hFfJQQ1102DCpDOEchQanm0ynIhAAP8
	FWQh92j61BvasNBBrvkIle0Gqz+2edt/6h2NQse5lY38t6sUeD9W2aAYKg==
X-Gm-Gg: ASbGncu4kvsSS3+Pd6qLDYfCQ4DTBOHOCEZCCsUj2TRzQJ13plyLuYbkDPX+0i89F69
	EcmsCYZY5gkrHwIbPxo2DWe3pot0awZXKOqFo3lU7qIn4A+N2INA2QP8+nshB9QFdigPJvk2TsL
	Z2t7k+9gUtaMYWE2w9LPXPtFLrXixwrRyReBaqFwdti1TIGn6iRNyWAMAIsdKLGiCZC2/Tbwivl
	n+z3xqdqIUM4tf5RpB1eL9IfUpCSj22gD7WG3waRYZos8jTFN9fSH/ewOo2d5pUn5U9w8KMBRNE
X-Google-Smtp-Source: AGHT+IFA7OOOCd9snq71zpXwBTEwLyd2JS9MSlzix+mOxpnYXN4r4eO+5LA/Zr3aVSqQYhkl1tRlDQ==
X-Received: by 2002:a05:6830:6a14:b0:71d:429c:e818 with SMTP id 46e09a7af769-71d65ce855cmr9861227a34.20.1732895939284;
        Fri, 29 Nov 2024 07:58:59 -0800 (PST)
Received: from pipaware.tx.rr.com ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71d725f2251sm794385a34.68.2024.11.29.07.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 07:58:58 -0800 (PST)
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
To: corbet@lwn.net,
	avadhut.naik@amd.com,
	bilbao@vt.edu
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Subject: [PATCH 3/7] docs/sp_SP: Add translation of process/5.Posting.rst
Date: Fri, 29 Nov 2024 09:58:43 -0600
Message-ID: <20241129155851.1023884-4-carlos.bilbao.osdev@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241129155851.1023884-1-carlos.bilbao.osdev@gmail.com>
References: <20241129155851.1023884-1-carlos.bilbao.osdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Avadhut Naik <avadhut.naik@amd.com>

Translate Documentation/process/5.Posting.rst into Spanish.

Co-developed-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
---
 .../translations/sp_SP/process/5.Posting.rst  | 388 +++++++++++++++++-
 .../sp_SP/process/development-process.rst     |   1 +
 2 files changed, 385 insertions(+), 4 deletions(-)

diff --git a/Documentation/translations/sp_SP/process/5.Posting.rst b/Documentation/translations/sp_SP/process/5.Posting.rst
index 50a3bc5998a8..9e2ac9fdd63d 100644
--- a/Documentation/translations/sp_SP/process/5.Posting.rst
+++ b/Documentation/translations/sp_SP/process/5.Posting.rst
@@ -1,11 +1,391 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: Documentation/process/5.Posting.rst
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com> and Avadhut Naik <avadhut.naik@amd.com>
 
 .. _sp_development_posting:
 
-Publicar parches
-================
+Publicación de parches
+======================
 
-.. warning::
-	TODO aún no traducido
+Tarde o temprano, llega el momento en que su trabajo esté listo para ser
+presentado a la comunidad para su revisión y, eventualmente, su inclusión
+en el kernel mainline. Como era de esperar, la comunidad de desarrollo del
+kernel ha desarrollado un conjunto de convenciones y procedimientos que se
+utilizan en la publicación de parches; seguirlos hará la vida mucho más
+fácil para todos los involucrados. Este documento intentará cubrir estas
+expectativas con un detalle razonable; también se puede encontrar más
+información en los archivos.
+:ref:`Documentation/translations/sp_SP/process/submitting-patches.rst <sp_submittingpatches>`
+and :ref:`Documentation/translations/sp_SP/process/submit-checklist.rst <sp_submitchecklist>`
+
+Cuando publicar
+---------------
+
+Hay una tentación constante de evitar publicar parches antes de que
+estén completamente “listos”. Para parches simples, eso no es un
+problema. Sin embargo, si el trabajo que se está realizando es complejo,
+hay mucho que ganar al obtener comentarios de la comunidad antes de que
+se complete el trabajo. Por lo tanto, se debería considerar publicar
+trabajo en progreso, o incluso poner a disposición un árbol de git para
+que los desarrolladores interesados puedan ponerse al día con su trabajo
+en cualquier momento.
+
+Al publicar código que aún no se considera listo para su inclusión, es
+una buena idea decirlo en la propia publicación. Además, mencione
+cualquier trabajo importante que aún falte por hacer y cualquier problema
+conocido. Menos personas mirarán los parches que se sabe que están a
+medias, pero aquellos que lo hagan vendrán con la idea de que pueden
+ayudarlo a llevar el trabajo en la dirección correcta.
+
+Antes de crear parches
+----------------------
+
+Se deben hacer varias cosas antes de considerar enviar parches a la
+comunidad de desarrollo. Estas incluyen:
+
+ - Pruebe el código en la medida de lo posible. Utilice las herramientas
+   de depuración del kernel, asegúrese de que el kernel se compilará con
+   todas las combinaciones razonables de opciones de configuración, use
+   compiladores cruzados para compilar para diferentes arquitecturas, etc.
+
+ - Asegúrese de que su código cumpla con las directrices de estilo de
+   codificación del kernel.
+
+ - ¿Su cambio tiene implicaciones de rendimiento? Si es así, debe ejecutar
+   puntos de referencia que muestren cuál es el impacto (o beneficio) de
+   su cambio; se debe incluir un resumen de los resultados con el parche.
+
+ - Asegúrese de que tiene derecho a publicar el código. Si este trabajo
+   se realizó para un empleador, es probable que el empleador tenga
+   derecho al trabajo y debe estar de acuerdo con su lanzamiento bajo la
+   GPL.
+
+Como regla general, pensar un poco más antes de publicar el código casi
+siempre compensa el esfuerzo en poco tiempo.
+
+Preparación del parche
+----------------------
+
+La preparación de parches para su publicación puede ser una cantidad
+sorprendente de trabajo, pero, una vez más, intentar ahorrar tiempo aquí
+generalmente no es recomendable, ni siquiera a corto plazo.
+
+Los parches deben prepararse contra una versión específica del kernel.
+Como regla general, un parche debe basarse en el mainline actual que se
+encuentra en el árbol git de Linus. Al basarse en el mainline, comience
+con un punto de lanzamiento bien conocido, una versión estable o -rc, en
+lugar de bifurcarse fuera del mainline en un punto arbitrario.
+
+Puede ser necesario hacer revisiones contra -mm, linux-next o un árbol de
+subsistemas para facilitar pruebas y revisiones más amplias. Dependiendo
+del área de su parche y de lo que esté sucediendo en otros lugares, basar
+un parche en estos otros árboles puede requerir una cantidad significativa
+de trabajo para resolver conflictos y lidiar con los cambios de API.
+
+Solo los cambios más simples deben formatearse como un solo parche; todo
+lo demás debe hacerse como una serie lógica de cambios. Dividir parches
+es un poco un arte; algunos desarrolladores pasan mucho tiempo averiguando
+cómo hacerlo de la manera que la comunidad espera. Sin embargo, hay
+algunas reglas generales que pueden ayudar considerablemente:
+
+ - La serie de parches que publique casi seguramente no será la serie de
+   cambios que se encuentran en su sistema de control de revisiones. En su
+   lugar, los cambios que ha realizado deben considerarse en su forma
+   final y luego dividirse de manera que tengan sentido. A los
+   desarrolladores les interesan los cambios discretos y autónomos, no el
+   camino que tomó para llegar a esos cambios.
+
+ - Cada cambio lógicamente independiente debe formatearse como un parche
+   separado. Estos cambios pueden ser pequeños (“agregar un campo a esta
+   estructura”) o grandes (agregar un nuevo controlador significativo,
+   por ejemplo), pero deben ser conceptualmente pequeños y susceptibles
+   de una descripción de una línea. Cada parche debe hacer un cambio
+   especifico que pueda ser revisado por sí mismo y verificado para hacer
+   lo que dice que hace.
+
+ - Para reafirmar la pauta anterior: no mezcle diferentes tipos de cambios
+   en el mismo parche. Si un solo parche corrige un error de seguridad
+   crítico, reorganiza algunas estructuras y reformatea el código, es muy
+   probable que se pase por alto y se pierda la solución importante.
+
+ - Cada parche debe producir un kernel que se compile y funcione
+   correctamente; si su serie de parches se interrumpe en el medio, el
+   resultado debería seguir siendo un kernel funcional. La aplicación
+   parcial de una serie de parches es un escenario común cuando se
+   utiliza la herramienta “git bisect” para encontrar regresiones; si
+   el resultado es un kernel roto, hará la vida más difícil para los
+   desarrolladores y usuarios que participan en el noble trabajo de
+   rastrear problemas.
+
+ - Sin embargo, no lo exagere. Un desarrollador una vez publicó un conjunto
+   de ediciones en un solo archivo como 500 parches separados – un acto
+   que no lo convirtió en la persona más popular en la lista de correo del
+   kernel. Un solo parche puede ser razonablemente grande si todavía
+   contiene un solo cambio *lógico*.
+
+ - Puede ser tentador agregar una infraestructura completamente nueva con
+   una serie de parches, pero dejar esa infraestructura sin usar hasta el
+   parche final de la serie lo habilite todo. Esta tentación debe evitarse
+   si es posible; si esa serie agrega regresiones, bisection señalará el
+   ultimo parche como el que causó el problema, aunque el error real esté
+   en otra parte. Siempre que sea posible, un parche que agregue código
+   nuevo debe hacer que ese código se active de inmediato.
+
+Trabajar para crear la serie de parches perfecta puede ser un proceso
+frustrante que lleva mucho tiempo y reflexión después de que el “trabajo
+real” se ha hecho. Sin embargo, cuando se hace correctamente, es un tiempo
+bien empleado.
+
+Formato de parches y registros de cambios
+-----------------------------------------
+
+Así que ahora tiene una serie perfecta de parches para publicar, pero el
+trabajo aún no se ha hecho. Cada parche necesita ser formateado en un
+mensaje que comunique rápida y claramente su propósito al resto del
+mundo. A tal fin, cada parche se compondrá de lo siguiente:
+
+ - Una línea opcional “From” que nombra al autor del parche. Esta línea
+   solo es necesaria si pasa el parche de otra persona por correo
+   electrónico, pero nunca está de más agregarla en caso de duda.
+
+ - Una descripción de una línea de lo que hace el parche. Este mensaje
+   debería ser suficiente para que un lector que lo vea sin otro contexto
+   pueda entender el alcance del parche; la línea aparecerá en los
+   registros de cambios de “forma corta”. Este mensaje generalmente se
+   formatea con el nombre del subsistema relevante primero, seguido del
+   propósito del parche. Por ejemplo:
+
+   ::
+
+	gpio: fix build on CONFIG_GPIO_SYSFS=n
+
+ - Una línea en blanco seguida de una descripción detallada del contenido
+   del parche. Esta descripción puede ser tan larga como sea necesario;
+   debería decir qué hace el parche y por qué debe aplicarse al kernel.
+
+ - Una o más líneas de etiquetas, con, como mínimo, una línea
+   Signed-off-by: del autor del parche. Las etiquetas se describirán con
+   más detalle a continuación.
+
+Los elementos de arriba, juntos, forman el registro de cambios para el
+parche. Escribir buenos registros de cambios es un arte crucial, pero a
+menudo descuidado; vale la pena pasar otro momento discutiendo este tema.
+Al escribir un registro de cambios, debe recordar que muchas personas
+diferentes leerán sus palabras. Estos incluyen a los maintainers y
+revisores de subsistemas que necesitan decidir si el parche debe
+incluirse, a los distribuidores y otros maintainers que intentan
+determinar si un parche debe ser “backported” a otros kernels, a los
+cazadores de errores que se preguntan si el parche es responsable de un
+problema que están persiguiendo, a los usuarios que quieren saber cómo
+ha cambiado el kernel, y más. Un buen registro de cambios transmite la
+información necesaria a todas estas personas de la forma más directa y
+concisa posible.
+
+Con ese fin, la línea de resumen debe describir los efectos y la
+motivación del cambio, así como lo mejor posible dada la restricción de
+una línea. La descripción detallada puede ampliar esos temas y
+proporcionar cualquier información adicional necesaria. Si el parche
+corrige un error, cita el commit que introdujo el error si es posible (y
+por favor, proporcione tanto el ID del commit como el título al citar
+commits). Si un problema está asociado con un registro específico o la
+salida del compilador, incluya esa salida para ayudar a otros usuarios a
+buscar una solución al mismo problema. Si el cambio está destinado a
+apoyar otros cambios que llegarán en un parche posterior, dígalo. Si se
+cambian las API internas, detalle esos cambios y cómo deben responder
+otros desarrolladores. En general, cuanto más pueda ponerse en los zapatos
+de todos los que leerán su registro de cambios, mejor será ese registro de
+cambios (y el kernel en su conjunto).
+
+No hace falta decir que el registro de cambios debe ser el texto utilizado
+al realizar el commit en un sistema de control de revisiones. Será seguido
+por:
+
+ - El parche, en el formato unificado de parche (“-u”). Usar la opción
+   “-p” en diff asociará los nombres de las funciones con los cambios, lo
+   que hará que el parche resultante sea más fácil de leer para otros.
+
+Debe evitar incluir cambios en archivos irrelevantes (los generados por
+el proceso de compilación, por ejemplo, o los archivos de respaldo del
+editor) en el parche. El archivo “dontdiff” en el directorio de
+Documentation puede ayudar en este sentido; páselo a diff con la
+opción “-X”.
+
+Las etiquetas ya mencionadas brevemente anteriormente proporcionan
+información sobre cómo surgió el parche. Se describen en detalle en el
+documento
+:ref:`Documentation/translations/sp_SP/process/submitting-patches.rst <sp_submittingpatches>`;
+lo que sigue aquí es un breve resumen.
+
+Una etiqueta se usa para referirse a commits anteriores que introdujeron
+problemas corregidos por el parche::
+
+	Fixes: 1f2e3d4c5b6a ("La primera línea del commit especificada por los primeros 12 caracteres de su ID SHA-1.")
+
+Otra etiqueta se utiliza para vincular páginas web con información
+adicional o detalles, por ejemplo, una discusión previa que condujo al
+parche o un documento con una especificación implementada por el parche::
+
+	Link: https://example.com/somewhere.html  otras cosas opcionales
+
+Muchos maintainers, al aplicar un parche, también agregan esta etiqueta
+para vincular a la última publicación de revisión pública del parche; a
+menudo, eso se hace automáticamente mediante herramientas como b4 o git
+hook como el que se describe en
+'Documentation/maintainer/configure-git.rst'.
+
+Si la URL apunta a un informe de error público que está siendo corregido
+por el parche, use la etiqueta “Closes:” (Cierra) en su lugar::
+
+	Closes: https://example.com/issues/1234  otras cosas opcionales
+
+Algunos rastreadores de errores tienen la capacidad de cerrar problemas
+automáticamente cuando se aplica un commit con tal etiqueta. Algunos bots
+que monitorean listas de correo también pueden rastrear dichas etiquetas
+y realizar ciertas acciones. Los rastreadores de errores privados y las
+URL no válidas están prohibidos.
+
+Otro tipo de etiqueta se utiliza para documentar quién estuvo involucrado
+en el desarrollo del parche. Cada uno de estos utiliza este formato::
+
+	tag: Full Name <email address>  otras cosas opcionales
+
+Las etiquetas de uso común son:
+
+ - Signed-off-by: esta es una certificación del desarrollador de que él
+   o ella tiene el derecho de enviar el parche para su inclusión en el
+   kernel. Es un acuerdo con el Certificado de Origen del Desarrollador,
+   que se encuentra en
+   :ref:`Documentation/translations/sp_SP/process/submitting-patches.rst <sp_submittingpatches>`.
+   El código sin la firma adecuada no se puede fusionar en el mainline.
+
+ - Co-developed-by: indica que el parche fue co-creado por varios
+   desarrolladores; se utiliza para atribuir a los coautores (además del
+   autor atribuido por la etiqueta From:) cuando varias personas trabajan
+   en un solo parche. Cada Co-developed-by: debe ir seguido inmediatamente
+   por un Signedoff-by: del coautor asociado. Los detalles y ejemplos se
+   pueden encontrar en
+   :ref:`Documentation/translations/sp_SP/process/submitting-patches.rst <sp_submittingpatches>`.
+
+ - Acked-by: indica un acuerdo por parte de otro desarrollador (a menudo
+   un maintainer del código relevante) de que el parche es apropiado para
+   su inclusión en el kernel.
+
+ - Tested-by: indica que la persona nombrada ha probado el parche y ha
+   encontrado que funciona.
+
+ - Reviewed-by: el desarrollador nombrado ha revisado el parche para
+   verificar que sea correcto; consulte la declaración del revisor en
+   :ref:`Documentation/translations/sp_SP/process/submitting-patches.rst <sp_submittingpatches>`
+   para obtener más detalles.
+
+ - Reported-by: nombra a un usuario que informó un problema que se
+   soluciona con este parche; esta etiqueta se utiliza para dar crédito
+   a las personas (a menudo infravalorada) que prueban nuestro código y
+   nos hacen saber cuándo las cosas no funcionan correctamente. Tenga en
+   cuenta que esta etiqueta debe ir seguida de una etiqueta Closes: que
+   apunte al informe, a menos que el informe no esté disponible en la
+   web. La etiqueta Link: se puede usar en lugar de Closes: si el parche
+   corrige una parte de los problemas reportados.
+
+ - Cc: la persona nombrada recibió una copia del parche y tuvo la
+   oportunidad de comentar sobre él.
+
+Tenga cuidado al agregar etiquetas a sus parches, ya que solo Cc: es
+apropiado para la adición sin el permiso explícito de la persona nombrada;
+usar Reported-by: está casi bien en su mayoría, pero pida permiso si el
+error fue reportado en privado.
+
+Envió del parche
+----------------
+
+Antes de enviar sus parches por correo, hay un par de cosas más de las
+que debe ocuparse:
+
+ - ¿Está seguro de que su correo no corromperá los parches? Los parches
+   con cambios gratuitos de espacio en blanco o ajuste de línea
+   realizados por el cliente de correo no se aplicarán en el otro
+   extremo, y a menudo, no se examinarán en detalle. Si tiene alguna
+   duda, envíese el parche por correo y convénzase de que parece
+   intacto.
+
+   :ref:`Documentation/translations/sp_SP/process/email-clients.rst <sp_email_clients>`
+   tiene algunos consejos útiles sobre cómo hacer que clientes de correo
+   específicos funcionen para enviar parches.
+
+ - ¿Está seguro de que su parche está libre de errores tontos? Siempre
+   debe ejecutar parches a través de scripts/checkpatch.pl y abordar las
+   quejas que surjan. Por favor, tenga en cuenta que checkpatch.pl, aunque
+   es la encarnación de una buena cantidad de pensamiento sobre cómo
+   deberían ser los parches del kernel, no es más inteligente que usted.
+   Si corregir una queja de checkpatch.pl empeoraría el código, no lo
+   haga.
+
+Los parches siempre deben enviarse como texto sin formato. Por favor, no
+los envíe como archivos adjuntos; eso hace que sea mucho más difícil para
+los revisores citar secciones del parche en sus respuestas. En su lugar,
+simplemente coloca el parche directamente en su mensaje.
+
+Al enviar parches por correo, es importante enviar copias a cualquier
+persona que pueda estar interesada en ellos. A diferencia de otros
+proyectos, el kernel anima a la gente a equivocarse por el lado de enviar
+demasiadas copias; no asuma que las personas relevantes verán su
+publicación en las listas de correo. En particular, las copias deben
+ir a:
+
+ - El (los) maintainer(s) del (de los) subsistema(s) afectado(s). Como se
+   describió anteriormente, el archivo MAINTAINERS es el primer lugar para
+   buscar a estas personas.
+
+ - Otros desarrolladores que han estado trabajando en la misma
+   área – especialmente aquellos que podrían estar trabajando allí ahora.
+   Usar git para ver quién más ha modificado los archivos en los que está
+   trabajando puede ser útil.
+
+ - Si está respondiendo a un informe de error o a una solicitud de
+   función, copie también al autor.
+
+ - Envié una copia a la lista de correo relevante o, si no se aplica nada
+   más, a la lista de linux-kernel.
+
+ - Si está corrigiendo un error, piense si la corrección debe incluirse en
+   la próxima actualización estable. Si es así, stable@vger.kernel.org
+   debería obtener una copia del parche. También agregue un
+   "Cc: stable@vger.kernel.org" a las etiquetas dentro del parche; eso
+   hará que el equipo estable reciba una notificación cuando su solución
+   incluya en el mainline.
+
+Al seleccionar destinatarios para un parche, es bueno saber quién cree que
+eventualmente aceptará el parche y lo fusionará. Aunque es posible enviar
+parches directamente a Linus Torvalds y hacer que los fusione, las cosas
+normalmente no se hacen de esa manera. Linus está ocupado y hay
+maintainers de subsistemas que vigilan partes específicas del kernel.
+Generalmente, querrá que ese maintainer fusione sus parches. Andrew Morton
+es a menudo el objetivo del parche de último recurso si no hay un
+maintainer obvio.
+
+Los parches necesitan buenas líneas de asunto. El formato canónico de una
+línea de parche es algo así como:
+
+::
+
+	[PATCH nn/mm] subsys: descripción en una línea del parche
+
+donde “nn” es el número ordinal del parche, “”mm” es el número total de
+parches en la serie, y “subsys” es el nombre del subsistema afectado.
+Claramente, nn/mm se puede omitir para un parche único e independiente.
+
+Si tiene una serie significativa de parches, es costumbre enviar una
+descripción introductoria como parte cero. Sin embargo, esta convención no
+se sigue universalmente; si la utiliza, recuerde que la información en la
+introducción no se incluye en los registros de cambios del kernel. Por lo
+tanto, asegúrese de que los parches, en sí mismos, tengan información
+completa del registro de cambios.
+
+En general, la segunda y las siguientes partes de un parche de varias
+partes deben enviarse como una respuesta a la primera parte para que todas
+se hilen juntas en el extremo receptor. Herramientas como git y quilt
+tienen comandos para enviar por correo un conjunto de parches con el
+subproceso adecuado. Sin embargo, si tiene una serie larga y está usando
+git, por favor evite la opción –chain-reply-to para evitar crear un
+anidamiento excepcionalmente profundo.
diff --git a/Documentation/translations/sp_SP/process/development-process.rst b/Documentation/translations/sp_SP/process/development-process.rst
index 62ee4b2e109e..fa078a18c1a7 100644
--- a/Documentation/translations/sp_SP/process/development-process.rst
+++ b/Documentation/translations/sp_SP/process/development-process.rst
@@ -27,3 +27,4 @@ para entenderla.
    2.Process
    3.Early-stage
    4.Coding
+   5.Posting
-- 
2.43.0


