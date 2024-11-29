Return-Path: <linux-kernel+bounces-425739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052399DEA08
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9F4163530
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 15:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2D814F9F9;
	Fri, 29 Nov 2024 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ml5FmBIS"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF87145B1D;
	Fri, 29 Nov 2024 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732895939; cv=none; b=d8JhyMmwqStxbsXA1gjt4/ig/EkqUCMj5vcpBMfrFvWHvtPK3cD070atm3G7oOpYZICmeq05Y2CY16/Vhby9csgGsuMQaTgyw23SydCrUelIRef6xPGrtcajaAuXUnJ41ZISOOx4Wc8FQXgQyibl9sVuKWiEiTvtTRuldv4Uie8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732895939; c=relaxed/simple;
	bh=38Iee4iP+AnwM/xmqSDKY0prqlEZMbMh88emZus4XxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQsETkiX1mhLXsOLocuBg0cQ6DIolD+U9pxDcXiX+/rLSU3Zt97qDyPTgv1OcM2OVTH+dtJP/LkaxkAj4y86qYgp8ajX5IJTRJQZlg1yxwa28IqARUy24qSsVj+QlBYwqAUMoRSnaCPSDyk31JH8uLCit3wEumHjX04x04tYW0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ml5FmBIS; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71d4c462ab1so771190a34.0;
        Fri, 29 Nov 2024 07:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732895936; x=1733500736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6CigXbvq9WM0qV1TtLzdk3QQaXrv+YjmLAcWjiR0k4=;
        b=Ml5FmBISwp8xa9NoW2JJuT6CcwhNnIOOCdk7c93E2VWQ8IwMPkfF+nbeswLax1y0LC
         EqPJWTssCJuQocVXXCBD8MoOqxt6WXESGPJSZpAxvskcJiXhOI541eakH/f4UsdBZ4gp
         PEsI8e1iYznyeglnUDHsY6IPuzCFTm5dMKls7vLlCi+awjNiYjEJilh5Ki3PIx08HON8
         xLrszywVbhnIgQgbs9w6nn5Aj8Dwq/DxpFguE4ylgqH1uebPUJt9KSFvNsbl3H8B2qkD
         CFrY/hfBZetWKG6bl3sE86ZybhBl+/CCPRI0Y4j1Z+czj73kMt9u0BjQhn+kiC6Y8IbV
         gd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732895936; x=1733500736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6CigXbvq9WM0qV1TtLzdk3QQaXrv+YjmLAcWjiR0k4=;
        b=VEhj/vPJiD6IMNkQVlaAwG4s6Cp9no7WkFyccioIwiPeuRKLk+2qnCY9HeNGliDzgN
         HLUH646ZniljdpZR+9QY67qr5TalZOO5cRoRvn7oOAUq4BZWEXZa33Ch8xCLQuLqww4m
         9cmU1oC4kbxAAt4tSsx3zNhEqxzLQYh7kslakPpr6sOZ7mCawfhbEvvwpaSb366RyV98
         XgS/7gNR9i10LjENdRoGAIf06FyywlSoXCVr0jx/SlHWBoVakaQ2Bak/uAYtn62HbqEH
         SbOxhMqj53nSmhORfLmz1hLesJ5IJ4+syoDcDvR8FmfFiFpYit3Z4NiNGvhXCjeB4KV3
         L1Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVKYI+uG6D3fC+SR/iwPXKW5vFmfGj3z3dfUNsL/xvOB+yOMFpMkMrbtwDPv9wp7wFpBbbRVnZKZ+VagOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvpKpHS4eAiX8kdXISucdoFgz18ItMhjkB5QekJmlevxsd7ahD
	mfEmXXsF1Hvm678PwFZ85MsdyHdljzaZrKk9bxniOxUQSdGXmd1DEhL7FA==
X-Gm-Gg: ASbGncslEaf3pnNaXhvlRmyUiXJIFbKdmZkxtUbptoDalTfnv/OEZQ/6rO1ZedPfF0E
	gYm0vUHWH4jUFKrHp0RN1gBp+iLD+4pE00tpG71Z18uLAcOri3AQvfV6kGUrEGAJxVfcWKo0KGu
	g55TtfGSuQZJRNBthTNBDNGrjpEjnH5d0A5CH6PxkRJ4Wgj8SLXVG++rhvpxwzuaRg1xTGXh33A
	G+IUtjY+C4VL6AtrD5UvECDOszjKJ3A4y3s9S0sTRgGNG8GxKzhW4oxflDbPitSWsBfdo7d5n+v
X-Google-Smtp-Source: AGHT+IGi+g/J+ETyJb7BSsmDZuPh9QPdLLbvsw4oIZeoRH/MMcp+IAgcppcuYqJYcvAf0sqTlKe7fQ==
X-Received: by 2002:a05:6830:34a8:b0:71d:4385:6662 with SMTP id 46e09a7af769-71d65d0556emr10507644a34.27.1732895936204;
        Fri, 29 Nov 2024 07:58:56 -0800 (PST)
Received: from pipaware.tx.rr.com ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71d725f2251sm794385a34.68.2024.11.29.07.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 07:58:55 -0800 (PST)
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
To: corbet@lwn.net,
	avadhut.naik@amd.com,
	bilbao@vt.edu
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Subject: [PATCH 1/7] docs/sp_SP: Add translation of process/3.Early-stage.rst
Date: Fri, 29 Nov 2024 09:58:41 -0600
Message-ID: <20241129155851.1023884-2-carlos.bilbao.osdev@gmail.com>
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

Translate Documentation/process/3.Early-stage.rst into Spanish.

Co-developed-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
---
 .../sp_SP/process/3.Early-stage.rst           | 234 +++++++++++++++++-
 .../sp_SP/process/development-process.rst     |   1 +
 2 files changed, 233 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/sp_SP/process/3.Early-stage.rst b/Documentation/translations/sp_SP/process/3.Early-stage.rst
index 71cfb3fb0fda..bb3c630c7fd4 100644
--- a/Documentation/translations/sp_SP/process/3.Early-stage.rst
+++ b/Documentation/translations/sp_SP/process/3.Early-stage.rst
@@ -1,11 +1,241 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: Documentation/process/3.Early-stage.rst
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com> and Avadhut Naik <avadhut.naik@amd.com>
 
 .. _sp_development_early_stage:
 
 Planificación en etapa inicial
 ==============================
 
-.. warning::
-	TODO aún no traducido
+Cuando uno se sienta a planear un proyecto de desarrollo del kernel Linux,
+puede ser tentador lanzarse directamente a escribir código. Sin embargo,
+como ocurre con cualquier proyecto significativo, gran parte del trabajo
+que conduce al éxito es mejor realizarlo antes de escribir la primera línea
+de código. Dedicar tiempo a la planificación y comunicación temprana puede
+ahorrar mucho más tiempo en adelante.
+
+Especificar el problema
+-----------------------
+
+Como en cualquier proyecto de ingeniería, una mejora exitosa del kernel
+comienza con una descripción clara del problema a resolver. En algunos
+casos, este paso es sencillo: cuando se necesita un driver para un hardware
+específico, por ejemplo. En otros, sin embargo, es tentador confundir el
+problema real con la solución propuesta, lo que puede generar dificultades.
+
+Consideremos un ejemplo: hace algunos años, los desarrolladores que
+trabajaban con audio en Linux buscaban una forma de ejecutar aplicaciones
+sin interrupciones u otros artefactos causados por la latencia excesiva en
+el sistema. La solución a la que llegaron fue un módulo del kernel
+destinado a integrarse en el marco del Módulo de Seguridad de Linux (LSM,
+por sus siglas en inglés); este módulo podía configurarse para dar acceso a
+aplicaciones específicas al planificador en tiempo real. Este módulo fue
+implementado y enviado a la lista de correo del kernel de Linux, donde
+inmediatamente encontró problemas.
+
+Para los desarrolladores de audio, este módulo de seguridad era suficiente
+para resolver su problema inmediato. Sin embargo, para la comunidad más
+amplia del kernel, se veía como un uso indebido del marco LSM (que no está
+diseñado para otorgar privilegios a procesos que de otro modo no los
+tendrían) y como un riesgo para la estabilidad del sistema. Sus soluciones
+preferidas implicaban el acceso a la programación en tiempo real a través
+del mecanismo de rlimit a corto plazo, y trabajo continuo para reducir la
+latencia a largo plazo.
+
+La comunidad de audio, sin embargo, no podía ver más allá de la solución
+particular que habían implementado; no estaban dispuestos a aceptar
+alternativas. El desacuerdo resultante dejó a esos desarrolladores
+desilusionados con todo el proceso de desarrollo del kernel; uno de ellos
+volvió a una lista de audio y publicó esto (traducido):
+
+	"Hay un buen número de desarrolladores muy competentes del kernel de Linux, pero tienden a ser opacados por una multitud de arrogantes necios. Intentar comunicar los requisitos de los usuarios a estas personas es una pérdida de tiempo. Son demasiado 'inteligentes' como para escuchar a simples mortales".
+
+Siendo el texto original:
+
+	There are a number of very good Linux kernel developers, but they
+	tend to get outshouted by a large crowd of arrogant fools. Trying
+	to communicate user requirements to these people is a waste of
+	time. They are much too "intelligent" to listen to lesser mortals.
+
+(https://lwn.net/Articles/131776/).
+
+La realidad de la situación era diferente; los desarrolladores del kernel
+estaban mucho más preocupados por la estabilidad del sistema, el
+mantenimiento a largo plazo y encontrar la solución correcta al problema
+que por un módulo específico. La moraleja de la historia es centrarse en el
+problema, no en una solución específica, y discutirlo con la comunidad de
+desarrollo antes de invertir en la creación de un cuerpo de código.
+
+Por lo tanto, al contemplar un proyecto de desarrollo del kernel, se deben
+obtener respuestas a un conjunto corto de preguntas:
+
+- ¿Cuál es exactamente el problema que necesita ser resuelto?
+
+- ¿Quiénes son los usuarios afectados por este problema? ¿Qué casos de uso
+  debería abordar la solución?
+
+- ¿En qué aspectos el kernel actual no logra abordar ese problema?
+
+Solo entonces tiene sentido comenzar a considerar posibles soluciones.
+
+Discusión temprana
+------------------
+
+Al planificar un proyecto de desarrollo del kernel, tiene mucho sentido
+realizar discusiones con la comunidad antes de lanzarse a la
+implementación. La comunicación temprana puede ahorrar tiempo y problemas
+de varias maneras:
+
+- Es posible que el problema ya esté siendo abordado por el kernel de
+  maneras que no haya comprendido. El kernel de Linux es grande y tiene
+  una serie de características y capacidades que no son inmediatamente
+  obvias. No todas las capacidades del kernel están documentadas tan bien
+  como uno quisiera, y es fácil pasar cosas por alto. El autor de este
+  texto ha visto la publicación de un driver completo que duplicaba uno
+  existente del que el nuevo autor no tenía conocimiento. El código que
+  reinventa ruedas existentes no solo es desperdicio; tampoco será aceptado
+  en el kernel principal.
+
+- Puede haber elementos de la solución propuesta que no serán aceptables
+  para su inclusión en el kernel principal. Es mejor descubrir problemas
+  como este antes de escribir el código.
+
+- Es completamente posible que otros desarrolladores ya hayan pensado en el
+  problema; pueden tener ideas para una mejor solución y estar dispuestos a
+  ayudar en la creación de esa solución.
+
+Años de experiencia con la comunidad de desarrollo del kernel han enseñado
+una lección clara: el código del kernel que se diseña y desarrolla a
+puertas cerradas invariablemente tiene problemas que solo se revelan cuando
+el código se libera a la comunidad. A veces, estos problemas son graves,
+requiriendo meses o años de esfuerzo antes de que el código pueda cumplir
+con los estándares de la comunidad del kernel. Algunos ejemplos incluyen:
+
+- La pila de red Devicescape fue diseñada e implementada para sistemas de
+  un solo procesador. No pudo fusionarse en la rama principal hasta que se
+  hizo adecuada para sistemas multiprocesador. Adaptar el bloqueo y otros
+  aspectos en el código es una tarea difícil; como resultado, la fusión de
+  este código (ahora llamado mac80211) se retrasó más de un año.
+
+- El sistema de archivos Reiser4 incluía una serie de capacidades que, en
+  opinión de los desarrolladores principales del kernel, deberían haberse
+  implementado en la capa de sistemas de archivos virtuales. También
+  incluía funciones que no podían implementarse fácilmente sin exponer el
+  sistema a bloqueos causados por los usuarios. La revelación tardía de
+  estos problemas, y la negativa a abordar algunos de ellos, ha mantenido a
+  Reiser4 fuera del kernel principal.
+
+- El módulo de seguridad AppArmor hacía uso de estructuras de datos
+  internas del sistema de archivos virtual de maneras que se consideraban
+  inseguras y poco fiables. Esta preocupación (entre otras) mantuvo a
+  AppArmor fuera de la rama principal durante años.
+
+En cada uno de estos casos, se podría haber evitado mucho dolor y trabajo
+adicional con algunas discusiones tempranas con los desarrolladores del
+kernel.
+
+¿Con quién hablar?
+-------------------
+
+Cuando los desarrolladores deciden hacer públicas sus ideas, la siguiente
+pregunta será: ¿dónde empezar? La respuesta es encontrar la lista de correo
+adecuada y el maintainer correcto. Para las listas de correo, la mejor
+opción es buscar en el archivo MAINTAINERS un lugar relevante para
+publicar. Si existe una lista de subsistema adecuada, es preferible
+publicarla allí en lugar de en linux-kernel; es más probable que llegues a
+desarrolladores con experiencia en el subsistema relevante y el ambiente
+puede ser más propicio.
+
+Encontrar a los maintainers puede ser un poco más difícil. Nuevamente, el
+archivo MAINTAINERS es el lugar para empezar. Sin embargo, ese archivo
+tiende a no estar siempre actualizado, y no todos los subsistemas están
+representados allí. La persona listada en el archivo MAINTAINERS puede, de
+hecho, no ser la persona que está actuando en ese rol actualmente. Por lo
+tanto, cuando haya dudas sobre a quién contactar, un truco útil es usar git
+(y "git log" en particular) para ver quién está activo actualmente en el
+subsistema de interés. Mira quién está escribiendo parches y quién, si
+alguien, está adjuntando líneas de Signed-off-by a esos parches. Esas son
+las personas que estarán mejor posicionadas para ayudar con un nuevo
+proyecto de desarrollo.
+
+La tarea de encontrar al maintainer correcto es lo suficientemente
+desafiante como para que los desarrolladores del kernel hayan añadido un
+script para facilitar el proceso:
+
+::
+
+	.../scripts/get_maintainer.pl
+
+Este script devolverá los maintainers actuales de un archivo o directorio
+dado cuando se le pase la opción "-f". Si se le pasa un parche en la línea
+de comandos, listará a los maintainers que probablemente deberían recibir
+copias del parche. Esta es la manera preferida (a diferencia de la opción
+"-f") de obtener la lista de personas a las que hay que enviar las copias
+de sus parches. Hay varias opciones que regulan cuán agresivamente
+get_maintainer.pl buscará maintainers; por favor, ten cuidado al usar las
+opciones más agresivas, ya que podrías terminar incluyendo desarrolladores
+que no tienen ningún interés real en el código que estás modificando.
+
+Si todo lo demás falla, hablar con Andrew Morton puede ser una forma
+efectiva de encontrar a un maintainer para un código específico.
+
+¿Cuándo publicar?
+------------------
+
+Si es posible, publicar sus planes en las primeras etapas solo puede ser
+útil. Describa el problema que se está resolviendo y cualquier plan que se
+haya hecho sobre cómo se llevará a cabo la implementación. Cualquier
+información que puedas proporcionar puede ayudar a la comunidad de
+desarrollo a ofrecer comentarios útiles sobre el proyecto.
+
+Una cosa desalentadora que puede suceder en esta etapa no es una reacción
+hostil, sino, en cambio, poca o ninguna reacción en absoluto. La triste
+realidad es que (1) los desarrolladores del kernel tienden a estar
+ocupados, (2) no hay escasez de personas con grandes planes y poco código
+(o incluso perspectivas de código) para respaldarlos, y (3) nadie está
+obligado a revisar o comentar las ideas publicadas por otros. Además, los
+diseños de alto nivel a menudo esconden problemas que solo se revelan
+cuando alguien realmente intenta implementar esos diseños; por esa razón,
+los desarrolladores del kernel prefieren ver el código.
+
+Si una publicación de solicitud de comentarios genera pocos comentarios, no
+asuma que significa que no hay interés en el proyecto. Desafortunadamente,
+tampoco puedes asumir que no hay problemas con tu idea. Lo mejor que puede
+hacer en esta situación es seguir adelante, manteniendo informada a
+comunidad a medida que avanza.
+
+Obtener respaldo oficial
+------------------------
+
+Si su trabajo se está realizando en un entorno corporativo — como ocurre
+con la mayoría del trabajo en el kernel de Linux — es obvio que debe tener
+permiso de los jefes debidamente autorizados antes de poder publicar los
+planes o el código de su empresa en una lista de correo pública. La
+publicación de código que no ha sido autorizado para su liberación bajo una
+licencia compatible con la GPL puede ser especialmente problemática; cuanto
+antes la gerencia y el personal legal de una empresa lleguen a un acuerdo
+sobre la publicación de un proyecto de desarrollo del kernel, mejor será
+para todos los involucrados.
+
+Algunos lectores pueden estar pensando en este momento que su trabajo en el
+kernel está destinado a respaldar un producto que aún no ha sido reconocido
+oficialmente. Revelar los planes de su empleador en una lista de correo
+pública puede no ser una opción viable. En casos como este, vale la pena
+considerar si realmente es necesario mantener el secreto; a menudo no hay
+una necesidad real de mantener los planes de desarrollo en secreto.
+
+Dicho esto, también hay casos en los que una empresa legítimamente no puede
+revelar sus planes al inicio del proceso de desarrollo. Las empresas con
+desarrolladores experimentados en el kernel pueden optar por proceder de
+manera abierta, bajo el supuesto de que podrán evitar problemas graves de
+integración más adelante. Para las empresas sin ese tipo de experiencia
+interna, la mejor opción suele ser contratar a un desarrollador externo
+para que revise los planes bajo un acuerdo de confidencialidad (NDA). La
+Linux Foundation opera un programa de NDA diseñado para ayudar en este tipo
+de situaciones; se puede encontrar más información en:
+
+    https://www.linuxfoundation.org/nda/
+
+Este tipo de revisión suele ser suficiente para evitar problemas graves más
+adelante sin necesidad de revelar públicamente el proyecto.
diff --git a/Documentation/translations/sp_SP/process/development-process.rst b/Documentation/translations/sp_SP/process/development-process.rst
index 40d74086f22e..8a967e569772 100644
--- a/Documentation/translations/sp_SP/process/development-process.rst
+++ b/Documentation/translations/sp_SP/process/development-process.rst
@@ -25,3 +25,4 @@ para entenderla.
 
    1.Intro
    2.Process
+   3.Early-stage
-- 
2.43.0


