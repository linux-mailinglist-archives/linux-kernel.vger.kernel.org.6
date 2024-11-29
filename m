Return-Path: <linux-kernel+bounces-425740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5839DEA0B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEE19B21297
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 15:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A9D19CCF5;
	Fri, 29 Nov 2024 15:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akHnVTSW"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A4914A4CC;
	Fri, 29 Nov 2024 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732895941; cv=none; b=Lg5A/6EuEEtk65bdERJEDbMkiIF5fMYG27E9SzSUubTa5WpqAtzXFOFIAbBpD7P7IEN88RTlHlkUMYiOXejcpp3IKUXR24XBji+qRMu4bUTY0Cp/efHUQBxZHKyupRM4ffblZcYZQNpRg+UzHzuDICyj52E+L8c6rGmmPFHWfmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732895941; c=relaxed/simple;
	bh=FN/kgNPUhuXmSgJzmYJC6RBkOk0pUs0foA9dAASqRcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3YAd6qvYo6VEmmYXrTmIq4vYX/AT8HEvgJ8uMc1ui3uMPvr9bM8IPnhd86IoWeUXvbgmuwBHnE6UzOVKCT1Cl+ngSUXv8U8Ft4oauHhACWhMv4guoViWis1BWR6bPNzEVvHRxyEUqinruxL9Jx3kbOuqx6Z9rcPTl+rlirxNMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akHnVTSW; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71d41932d32so778716a34.0;
        Fri, 29 Nov 2024 07:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732895938; x=1733500738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wJIg/sxtDsSUo2Smlt0dgu9NBkc52JfvgQN+3tMwkU=;
        b=akHnVTSWljKhXZZdq6lri1lti3F0S85yIbKKIjLna99Wjsevy+QZoFgbWWeme//HYw
         hdsYeDjPTSvHMqNEcGTogNFgO8wNdfgp1r6w8FhDDYfDwCB81udzVUhOAMX2gjPZrOa3
         guG3vCBoCWBq9zdeqSGzmy+aVePDpGejB31a1/Y/paVC3vvKDgIChDI5LskYa1JVa1AM
         GOeTTQGjnDkVIbkMEdb45V0TE9dnWkVOiucRbAG5pYWBjQ2j1nG/icqBppe6PICnJfP+
         hKgI86CebZ5a/hTHfVCWzn0/EpJll8GbSTth3lMWlIffxQ89BldzkbvZ6V5Gf+anWwF+
         qbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732895938; x=1733500738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wJIg/sxtDsSUo2Smlt0dgu9NBkc52JfvgQN+3tMwkU=;
        b=nBDy1pWTS5BhboFJf3a4LmzeRuJbkedjc46FAhWNgkcwiQ8mpZxXKtrZ7gzZL0phV/
         zFMj7rvEfw2/f7HK70I89sU+FMkbiWbIO6GRJ8MkAes/ix9HgVmFKDo0EGxThffjy7Bp
         XM3o0pMXv9qDIEInHz/7NErT18CUlf8mGG0+t5r871YWcgRLM3MGBsbDkyTlmynfsOuP
         UrBKqoTzP1p4N9NR6WMWQcOwGumHNgbSOLEinsz7C/oA021N+ouwisG7IU8rTxRfvxZt
         1t77Ex7OgbXT1XiZHE0VuHik0IyxWpAa1UtNRrhLHhEKIcJ1jbj9jttEiO1DCI4gVMNR
         ZNpw==
X-Forwarded-Encrypted: i=1; AJvYcCUWhiKwyz3nJGKxbvRI3pFXeVcMeYEw9M/8B2C/pVHyHEXmWCn3bJrCi5tpiYypl7TDv6pQ4yqk/cPhfco=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGgdgP3DVPTx+uNBA4zvxbaIBFyRXGmBErkSap4vjFFv2I93d/
	sp18+4t7hhdDR+Qb1OBCv3oyaNpzcguWuIhgWxhqwPmX1Ot+IPR4
X-Gm-Gg: ASbGncs4XAvAhvkPOI9sDamonp9MS6SDCNxlOvH3NdxyLa2nVG29fUYjncTam9SDFvi
	pfU+8Wsxdw3sF3NjASQUgaRdclOljw216pCPwDh5n0JY2fiYoFcAUTIopI0BJfh3kZ/hq+2+6me
	sJYrYnt1ZEZy1dhea80XS7Qczj9GjfBIUTPickEImVB9zH0icdBgQn21ymqWxTnmhR8xaJSOK2j
	yIwj3tLhlwIp9bIWxu9s288tNj8yDl6IUC2yKaPaK8DeHWE9KN0D8oXdK7oArU9WdRqQ2xFU5Zh
X-Google-Smtp-Source: AGHT+IE2VcF/MSwNHS6hN8HzVuhroZFj9OBsXvwDuziygvANH4/lTvjHkaVRJBLDQdldAtq5y9YW8Q==
X-Received: by 2002:a05:6830:349a:b0:71d:53b7:6433 with SMTP id 46e09a7af769-71d65a93f2fmr11541443a34.0.1732895937878;
        Fri, 29 Nov 2024 07:58:57 -0800 (PST)
Received: from pipaware.tx.rr.com ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71d725f2251sm794385a34.68.2024.11.29.07.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 07:58:57 -0800 (PST)
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
To: corbet@lwn.net,
	avadhut.naik@amd.com,
	bilbao@vt.edu
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Subject: [PATCH 2/7] docs/sp_SP: Add translation of process/4.Coding.rst
Date: Fri, 29 Nov 2024 09:58:42 -0600
Message-ID: <20241129155851.1023884-3-carlos.bilbao.osdev@gmail.com>
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

Translate Documentation/process/4.Coding.rst into Spanish.

Co-developed-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
---
 .../translations/sp_SP/process/4.Coding.rst   | 463 +++++++++++++++++-
 .../sp_SP/process/development-process.rst     |   1 +
 2 files changed, 462 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/sp_SP/process/4.Coding.rst b/Documentation/translations/sp_SP/process/4.Coding.rst
index d9436e039b4b..7cc347c34354 100644
--- a/Documentation/translations/sp_SP/process/4.Coding.rst
+++ b/Documentation/translations/sp_SP/process/4.Coding.rst
@@ -1,11 +1,470 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: Documentation/process/4.Coding.rst
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com> and Avadhut Naik <avadhut.naik@amd.com>
 
 .. _sp_development_coding:
 
 Conseguir el código correcto
 ============================
 
-.. warning::
-	TODO aún no traducido
+Si bien hay mucho que decir a favor de un proceso de diseño sólido y
+orientado a la comunidad, la prueba de cualquier proyecto de desarrollo del
+kernel está en el código resultante. Es el código lo que será examinado por
+otros desarrolladores y lo que será incluido (o no) en el árbol principal.
+Por lo tanto, es la calidad de este código lo que determinará el éxito
+final del proyecto.
+
+Esta sección examinará el proceso de programación. Comenzaremos observando
+algunas de las maneras en que los desarrolladores del kernel pueden cometer
+errores. Luego, el enfoque se dirigirá hacia hacer las cosas bien y las
+herramientas que pueden ayudar en dicha búsqueda.
+
+Problemas
+---------
+
+Estilo de programación
+**********************
+
+El kernel ha tenido durante mucho tiempo un estilo de programación
+estándar, descrito en la documentación del kernel en
+`Documentation/process/coding-style.rst`. Durante gran parte de ese tiempo,
+las políticas descritas en ese archivo se tomaban como, en el mejor de los
+casos, orientativas. Como resultado, hay una cantidad considerable de
+código en el kernel que no cumple con las pautas de estilo de programación.
+La presencia de ese código lleva a dos peligros independientes para los
+desarrolladores del kernel.
+
+El primero de estos es creer que los estándares de programación del kernel
+no importan y no se aplican. La realidad es que agregar nuevo código al
+kernel es muy difícil si ese código no está escrito de acuerdo con el
+estándar; muchos desarrolladores solicitarán que el código sea reformateado
+antes de revisarlo. Una base de código tan grande como el kernel requiere
+cierta uniformidad para que los desarrolladores puedan comprender
+rápidamente cualquier parte de él. Así que ya no hay lugar para el código
+con formato extraño.
+
+Ocasionalmente, el estilo de programación del kernel entrará en conflicto
+con el estilo obligatorio de un empleador. En tales casos, el estilo del
+kernel tendrá que prevalecer antes de que el código pueda ser fusionado.
+Incluir código en el kernel significa renunciar a cierto grado de control
+de varias maneras, incluida la forma en que se formatea el código.
+
+La otra trampa es asumir que el código que ya está en el kernel necesita
+urgentemente correcciones de estilo de programación. Los desarrolladores
+pueden comenzar a generar parches de reformateo como una forma de
+familiarizarse con el proceso o como una forma de incluir su nombre en los
+registros de cambios del kernel, o ambos. Pero las correcciones puramente
+de estilo de programación son vistas como ruido por la comunidad de
+desarrollo; tienden a recibir una recepción adversa. Por lo tanto, este
+tipo de parche es mejor evitarlo. Es natural corregir el estilo de una
+parte del código mientras se trabaja en él por otras razones, pero los
+cambios de estilo de programación no deben hacerse por sí mismos.
+
+El documento de estilo de programación tampoco debe leerse como una ley
+absoluta que nunca puede transgredirse. Si hay una buena razón para ir en
+contra del estilo (una línea que se vuelve mucho menos legible si se divide
+para ajustarse al límite de 80 columnas, por ejemplo), perfecto.
+
+Tenga en cuenta que también puedes usar la herramienta `clang-format` para
+ayudarle con estas reglas, para reformatear rápidamente partes de su código
+automáticamente y para revisar archivos completos a fin de detectar errores
+de estilo de programación, errores tipográficos y posibles mejoras. También
+es útil para ordenar `#includes`, alinear variables/macros, reformatear
+texto y otras tareas similares. Consulte el archivo
+`Documentation/dev-tools/clang-format.rst` para más detalles.
+
+Algunas configuraciones básicas del editor, como la indentación y los
+finales de línea, se configurarán automáticamente si utilizas un editor
+compatible con EditorConfig. Consulte el sitio web oficial de EditorConfig
+para obtener más información: https://editorconfig.org/
+
+Capas de abstracción
+********************
+
+Los profesores de ciencias de la computación enseñan a los estudiantes a
+hacer un uso extensivo de capas de abstracción en nombre de la
+flexibilidad y el ocultamiento de la información. Sin duda, el kernel hace
+un uso extensivo de la abstracción; ningún proyecto que involucre varios
+millones de líneas de código podría sobrevivir de otra manera. Pero la
+experiencia ha demostrado que una abstracción excesiva o prematura puede
+ser tan perjudicial como la optimización prematura. La abstracción debe
+usarse en la medida necesaria y ya.
+
+A un nivel simple, considere una función que tiene un argumento que siempre
+se pasa como cero por todos los que la invocan. Uno podría mantener ese
+argumento por si alguien eventualmente necesita usar la flexibilidad
+adicional que proporciona. Sin embargo, para entonces, es probable que el
+código que implementa este argumento adicional se haya roto de alguna
+manera sutil que nunca se notó, porque nunca se ha utilizado. O, cuando
+surge la necesidad de flexibilidad adicional, no lo hace de una manera que
+coincida con la expectativa temprana del programador. Los desarrolladores
+del kernel rutinariamente enviarán parches para eliminar argumentos no
+utilizados; en general, no deberían añadirse en primer lugar.
+
+Las capas de abstracción que ocultan el acceso al hardware, a menudo para
+permitir que la mayor parte de un controlador se utilice con varios
+sistemas operativos, son especialmente mal vistas. Dichas capas oscurecen
+el código y pueden imponer una penalización en el rendimiento; no
+pertenecen al kernel de Linux.
+
+Por otro lado, si se encuentra copiando cantidades significativas de código
+de otro subsistema del kernel, es hora de preguntar si, de hecho, tendría
+sentido extraer parte de ese código en una biblioteca separada o
+implementar esa funcionalidad a un nivel superior. No tiene sentido
+replicar el mismo código en todo el kernel.
+
+Uso de #ifdef y del preprocesador en general
+********************************************
+
+El preprocesador de C tiene una tentación poderosa para algunos
+programadores de C, quienes lo ven como una forma de programar
+eficientemente una gran cantidad de flexibilidad en un archivo fuente. Pero
+el preprocesador no es C, y el uso intensivo de él da como resultado un
+código mucho más difícil de leer para otros y más difícil de verificar por
+el compilador para su corrección. El uso intensivo del preprocesador es
+asi siempre un signo de un código que necesita algo de limpieza.
+
+La compilación condicional con `#ifdef` es, de hecho, una característica
+poderosa, y se usa dentro del kernel. Pero hay poco deseo de ver código que
+sté salpicado liberalmente con bloques `#ifdef`. Como regla general, el uso
+de `#ifdef` debe limitarse a los archivos de encabezado siempre que sea
+posible. El código condicionalmente compilado puede confinarse a funciones
+que, si el código no va a estar presente, simplemente se convierten en
+vacías. El compilador luego optimizará silenciosamente la llamada a la
+función vacía. El resultado es un código mucho más limpio y fácil de
+seguir.
+
+Las macros del preprocesador de C presentan varios peligros, incluida la
+posible evaluación múltiple de expresiones con efectos secundarios y la
+falta de seguridad de tipos. Si te sientes tentado a definir una macro,
+considera crear una función en línea en su lugar. El código resultante será
+el mismo, pero las funciones en línea son más fáciles de leer, no evalúan
+sus argumentos varias veces y permiten que el compilador realice
+comprobaciones de tipo en los argumentos y el valor de retorno.
+
+Funciones en línea
+******************
+
+Las funciones en línea presentan su propio peligro, sin embargo. Los
+programadores pueden enamorarse de la eficiencia percibida al evitar una
+llamada a función y llenar un archivo fuente con funciones en línea. Esas
+funciones, sin embargo, pueden en realidad reducir el rendimiento. Dado que
+su código se replica en cada sitio de llamada, terminan hinchando el tamaño
+del kernel compilado. Eso, a su vez, crea presión en las cachés de memoria
+del procesador, lo que puede ralentizar la ejecución de manera drástica
+Las funciones en línea, como regla, deben ser bastante pequeñas y
+relativamente raras. El costo de una llamada a función, después de todo, no
+es tan alto; la creación de un gran número de funciones en línea es un
+ejemplo clásico de optimización prematura.
+
+En general, los programadores del kernel ignoran los efectos de caché bajo
+su propio riesgo. El clásico intercambio de tiempo/espacio que se enseña en
+las clases de estructuras de datos iniciales a menudo no se aplica al
+hardware contemporáneo. El espacio *es* tiempo, en el sentido de que un
+programa más grande se ejecutará más lentamente que uno más compacto.
+
+Los compiladores más recientes toman un papel cada vez más activo al
+decidir si una función dada debe realmente ser en línea o no. Por lo tanto,
+la colocación liberal de palabras clave "inline" puede no solo ser
+excesiva; también podría ser irrelevante.
+
+Bloqueo
+*******
+
+En mayo de 2006, la pila de red "Devicescape" fue, con gran fanfarria,
+lanzada bajo la licencia GPL y puesta a disposición para su inclusión en el
+kernel principal. Esta donación fue una noticia bienvenida; el soporte para
+redes inalámbricas en Linux se consideraba, en el mejor de los casos,
+deficiente, y la pila de Devicescape ofrecía la promesa de solucionar esa
+situación. Sin embargo, este código no fue incluido en el kernel principal
+hasta junio de 2007 (versión 2.6.22). ¿Qué sucedió?
+
+Este código mostró varios signos de haber sido desarrollado a puertas
+cerradas en una empresa. Pero un problema importante en particular fue que
+no estaba diseñado para funcionar en sistemas multiprocesador. Antes de que
+esta pila de red (ahora llamada mac80211) pudiera fusionarse, se tuvo que
+implementar un esquema de bloqueo en ella.
+
+Hubo un tiempo en que se podía desarrollar código para el kernel de Linux
+sin pensar en los problemas de concurrencia que presentan los sistemas
+multiprocesador. Ahora, sin embargo, este documento se está escribiendo en
+una computadora portátil con dos núcleos. Incluso en sistemas de un solo
+procesador, el trabajo que se está realizando para mejorar la capacidad de
+respuesta aumentará el nivel de concurrencia dentro del kernel. Los días en
+que se podía escribir código para el kernel sin pensar en el bloqueo han
+quedado atrás.
+
+Cualquier recurso (estructuras de datos, registros de hardware, etc.) que
+pueda ser accedido concurrentemente por más de un hilo debe estar protegido
+por un bloqueo. El nuevo código debe escribirse teniendo en cuenta este
+requisito; implementar el bloqueo después de que el código ya ha sido
+desarrollado es una tarea mucho más difícil. Los desarrolladores del kernel
+deben tomarse el tiempo para comprender bien los primitivos de bloqueo
+disponibles para elegir la herramienta adecuada para el trabajo. El código
+que muestre una falta de atención a la concurrencia tendrá un camino
+difícil para ser incluido en el kernel principal.
+
+Regresiones
+***********
+
+Un último peligro que vale la pena mencionar es el siguiente: puede ser
+tentador realizar un cambio (que puede traer grandes mejoras) que cause un
+problema para los usuarios existentes. Este tipo de cambio se llama una
+"regresión", y las regresiones se han vuelto muy mal recibidas en el kernel
+principal. Con pocas excepciones, los cambios que causan regresiones serán
+revertidos si la regresión no se puede solucionar de manera oportuna. Es
+mucho mejor evitar la regresión desde el principio.
+
+A menudo se argumenta que una regresión puede justificarse si hace que las
+cosas funcionen para más personas de las que crea problemas. ¿Por qué no
+hacer un cambio si trae nueva funcionalidad a diez sistemas por cada uno
+que rompe? La mejor respuesta a esta pregunta fue expresada por Linus en
+julio de 2007 (traducido):
+
+::
+
+    Entonces, no arreglamos errores introduciendo nuevos problemas. Eso
+	lleva a la locura, y nadie sabe si realmente se avanza. ¿Es dos pasos
+	adelante, uno atrás, o un paso adelante y dos atrás?
+
+(https://lwn.net/Articles/243460/).
+
+Un tipo de regresión especialmente mal recibido es cualquier tipo de cambio
+en la ABI del espacio de usuario. Una vez que se ha exportado una interfaz
+al espacio de usuario, debe ser soportada indefinidamente. Este hecho hace
+que la creación de interfaces para el espacio de usuario sea
+particularmente desafiante: dado que no pueden cambiarse de manera
+incompatible, deben hacerse bien desde el principio. Por esta razón,
+siempre se requiere una gran cantidad de reflexión, documentación clara y
+una amplia revisión para las interfaces del espacio de usuario.
+
+Herramientas de verificación de código
+**************************************
+
+Por ahora, al menos, escribir código libre de errores sigue siendo un ideal
+que pocos de nosotros podemos alcanzar. Sin embargo, lo que podemos esperar
+hacer es detectar y corregir tantos de esos errores como sea posible antes
+de que nuestro código se integre en el kernel principal. Con ese fin, los
+desarrolladores del kernel han reunido una impresionante variedad de
+herramientas que pueden detectar una amplia variedad de problemas oscuros
+de manera automatizada. Cualquier problema detectado por el ordenador es
+un problema que no afectará a un usuario más adelante, por lo que es lógico
+que las herramientas automatizadas se utilicen siempre que sea posible.
+
+El primer paso es simplemente prestar atención a las advertencias
+producidas por el compilador. Las versiones contemporáneas de gcc pueden
+detectar (y advertir sobre) una gran cantidad de errores potenciales. Con
+bastante frecuencia, estas advertencias apuntan a problemas reales. El
+código enviado para revisión no debería, por regla general, producir
+ninguna advertencia del compilador. Al silenciar las advertencias, tenga
+cuidado de comprender la causa real e intente evitar "correcciones" que
+hagan desaparecer la advertencia sin abordar su causa.
+
+Tenga en cuenta que no todas las advertencias del compilador están
+habilitadas de forma predeterminada. Compile el kernel con
+"make KCFLAGS=-W" para obtener el conjunto completo.
+
+El kernel proporciona varias opciones de configuración que activan
+funciones de depuración; la mayoría de estas se encuentran en el submenú
+"kernel hacking". Varias de estas opciones deben estar activadas para
+cualquier kernel utilizado para desarrollo o pruebas. En particular,
+debería activar:
+
+ - FRAME_WARN para obtener advertencias sobre marcos de pila más grandes
+   que una cantidad determinada. La salida generada puede ser extensa, pero
+   no es necesario preocuparse por las advertencias de otras partes del
+   kernel.
+
+ - DEBUG_OBJECTS agregará código para rastrear la vida útil de varios
+   objetos creados por el kernel y advertir cuando se realicen cosas fuera
+   de orden. Si está agregando un subsistema que crea (y exporta) objetos
+   complejos propios, considere agregar soporte para la infraestructura de
+   depuración de objetos.
+
+ - DEBUG_SLAB puede encontrar una variedad de errores en la asignación y
+   uso de memoria; debe usarse en la mayoría de los kernels de desarrollo.
+
+ - DEBUG_SPINLOCK, DEBUG_ATOMIC_SLEEP y DEBUG_MUTEXES encontrarán una serie
+   de errores comunes de bloqueo.
+
+Hay bastantes otras opciones de depuración, algunas de las cuales se
+discutirán más adelante. Algunas de ellas tienen un impacto significativo
+en el rendimiento y no deben usarse todo el tiempo. Pero dedicar tiempo a
+aprender las opciones disponibles probablemente será recompensado muchas
+veces en poco tiempo.
+
+Una de las herramientas de depuración más pesadas es el verificador de
+bloqueos, o "lockdep". Esta herramienta rastreará la adquisición y
+liberación de cada bloqueo (spinlock o mutex) en el sistema, el orden en
+que se adquieren los bloqueos en relación entre sí, el entorno actual de
+interrupción, y más. Luego, puede asegurarse de que los bloqueos siempre se
+adquieran en el mismo orden, que las mismas suposiciones de interrupción se
+apliquen en todas las situaciones, y así sucesivamente. En otras palabras,
+lockdep puede encontrar varios escenarios en los que el sistema podría, en
+raras ocasiones, bloquearse. Este tipo de problema puede ser doloroso
+(tanto para desarrolladores como para usuarios) en un sistema desplegado;
+lockdep permite encontrarlos de manera automatizada con anticipación. El
+código con cualquier tipo de bloqueo no trivial debe ejecutarse con lockdep
+habilitado antes de ser enviado para su inclusión.
+
+Como programador diligente del kernel, sin duda alguna, verificará el
+estado de retorno de cualquier operación (como una asignación de memoria)
+que pueda fallar. Sin embargo, el hecho es que las rutas de recuperación de
+fallos resultantes probablemente no hayan sido probadas en absoluto. El
+código no probado tiende a ser código roto; podría tener mucha más
+confianza en su código si todas esas rutas de manejo de errores se hubieran
+ejercitado algunas veces.
+
+El kernel proporciona un marco de inyección de fallos que puede hacer
+precisamente eso, especialmente donde están involucradas las asignaciones
+de memoria. Con la inyección de fallos habilitada, un porcentaje
+configurable de las asignaciones de memoria fallarán; estas fallas pueden
+restringirse a un rango específico de código. Ejecutar con la inyección de
+fallos habilitada permite al programador ver cómo responde el código cuando
+las cosas van mal. Consulte
+Documentation/fault-injection/fault-injection.rst para obtener más
+información sobre cómo utilizar esta funcionalidad.
+
+Otros tipos de errores se pueden encontrar con la herramienta de análisis
+estático "sparse". Con sparse, el programador puede recibir advertencias
+sobre confusiones entre direcciones del espacio de usuario y del kernel,
+mezcla de cantidades big-endian y little-endian, el paso de valores enteros
+donde se espera un conjunto de banderas de bits, y así sucesivamente.
+Sparse debe instalarse por separado (puede encontrarse en
+https://sparse.wiki.kernel.org/index.php/Main_Page si su distribución no lo
+empaqueta); luego, puede ejecutarse en el código agregando "C=1" a su
+comando make.
+
+La herramienta "Coccinelle" (http://coccinelle.lip6.fr/) puede encontrar
+una amplia variedad de posibles problemas de codificación; también puede
+proponer correcciones para esos problemas. Bastantes "parches semánticos"
+para el kernel se han empaquetado en el directorio scripts/coccinelle;
+ejecutar "make coccicheck" ejecutará esos parches semánticos e informará
+sobre cualquier problema encontrado. Consulte:
+ref:`Documentation/dev-tools/coccinelle.rst <devtools_coccinelle>` para
+obtener más información.
+
+Otros tipos de errores de portabilidad se encuentran mejor compilando su
+código para otras arquitecturas. Si no tiene un sistema S/390 o una placa
+de desarrollo Blackfin a mano, aún puede realizar el paso de compilación.
+Un gran conjunto de compiladores cruzados para sistemas x86 se puede
+encontrar en
+
+	https://www.kernel.org/pub/tools/crosstool/
+
+Muchos sistemas de compilación disponibles comercialmente también se pueden
+utilizar para compilar código de kernel para una amplia gama de
+arquitecturas.
+
+Los desarrolladores del kernel son afortunados: tienen acceso a una
+variedad de herramientas de verificación de código de la que los
+desarrolladores de la mayoría de los otros sistemas pueden estar celosos.
+Pero todas esas herramientas no servirán de nada si no las usa. El
+resultado final de ignorar estas herramientas es simple: alguien más puede
+notificarle de un problema en su código a través de un "oportuno"
+comentario en la lista de correo o, peor aún, el código problemático podría
+ser eliminado. Es mucho más fácil usar estas herramientas en primer lugar.
+
+Documentación
+*************
+
+La documentación a menudo ha sido más la excepción que la regla en el
+desarrollo del kernel. Aun así, una documentación adecuada ayudará a
+facilitar la integración de nuevo código en el kernel, hará la vida más
+fácil a otros desarrolladores, y será útil para sus usuarios. En muchos
+casos, la inclusión de documentación se ha vuelto esencialmente
+obligatoria.
+
+La primera pieza de documentación para cualquier parche es su changelog
+asociado. Las entradas de registro deben describir el problema que se está
+esolviendo, la forma de la solución, las personas que trabajaron en el
+parche, cualquier efecto relevante en el rendimiento, y cualquier otra cosa
+que pueda ser necesaria para entender el parche. Asegúrese de que el
+changelog diga *por qué* el parche vale la pena ser aplicado; un
+sorprendente número de desarrolladores no proporciona esa información.
+
+Cualquier código que agregue una nueva interfaz para el espacio de usuario,
+incluidos los nuevos archivos de sysfs o /proc, debe incluir documentación
+de esa interfaz que permita a los desarrolladores del espacio de usuario
+saber con qué están trabajando. Consulte `Documentation/ABI/README` para
+una descripción de cómo debe formatearse esta documentación y qué
+información debe proporcionarse.
+
+El archivo
+:ref:`Documentation/admin-guide/kernel-parameters.rst <kernelparameters>`
+describe todos los parámetros de arranque del kernel. Cualquier parche que
+agregue nuevos parámetros debe agregar las entradas correspondientes a este
+archivo.
+
+Cualquier nueva opción de configuración debe ir acompañada de un texto de
+ayuda que explique claramente las opciones y cuándo el usuario podría
+querer seleccionarlas.
+
+La información de la API interna para muchos subsistemas está documentada
+mediante comentarios especialmente formateados; estos comentarios pueden
+extraerse y formatearse de diversas maneras mediante el script
+"kernel-doc". Si está trabajando dentro de un subsistema que tiene
+comentarios de kerneldoc, debe mantenerlos y agregarlos según corresponda
+para las funciones disponibles externamente. Incluso en áreas que no han
+sido tan documentadas, no hay ningún inconveniente en agregar comentarios
+de kerneldoc para el futuro; de hecho, esta puede ser una actividad útil
+para desarrolladores de kernel principiantes. El formato de estos
+comentarios, junto con alguna información sobre cómo crear plantillas de
+kerneldoc, se puede encontrar en
+:ref:`Documentation/doc-guide/ <doc_guide>`.
+
+Cualquiera que lea una cantidad significativa de código existente del
+kernel notará que, a menudo, los comentarios son notables por su ausencia.
+Una vez más, las expectativas para el nuevo código son más altas que en el
+pasado; integrar código sin comentarios será más difícil. Dicho esto, hay
+poco deseo de tener código excesivamente comentado. El código en sí debe
+ser legible, con comentarios que expliquen los aspectos más sutiles.
+
+Ciertas cosas siempre deben comentarse. El uso de barreras de memoria debe
+ir acompañado de una línea que explique por qué la barrera es necesaria.
+Las reglas de bloqueo para las estructuras de datos generalmente necesitan
+explicarse en algún lugar. Las estructuras de datos importantes en general
+necesitan documentación completa. Las dependencias no obvias entre
+fragmentos de código separados deben señalarse. Cualquier cosa que pueda
+tentar a un maintainer de código a hacer una "limpieza" incorrecta necesita
+un comentario que explique por qué se hace de esa manera. Y así
+sucesivamente.
+
+Cambios en la API interna
+*************************
+
+La interfaz binaria proporcionada por el kernel al espacio de usuario no se
+puede romper, excepto en las circunstancias más graves. Las interfaces de
+programación internas del kernel, en cambio, son altamente fluidas y pueden
+cambiarse cuando surge la necesidad. Si usted se encuentra teniendo que
+hacer un rodeo alrededor de una API del kernel, o simplemente no utilizando
+una funcionalidad específica porque no cumple con sus necesidades, eso
+puede ser una señal de que la API necesita cambiar. Como desarrollador del
+kernel, usted está autorizado a hacer esos cambios.
+
+Hay, por supuesto, algunas condiciones. Los cambios en la API se pueden
+hacer, pero necesitan estar bien justificados. Entonces, cualquier parche
+que realice un cambio en la API interna debe ir acompañado de una
+descripción de cuál es el cambio y por qué es necesario. Este tipo de
+cambio también debe desglosarse en un parche separado, en lugar de estar
+enterrado dentro de un parche más grande.
+
+La otra condición es que un desarrollador que cambia una API interna
+generalmente está encargado de la tarea de corregir cualquier código dentro
+del árbol del kernel que se vea afectado por el cambio. Para una función
+ampliamente utilizada, este deber puede llevar a literalmente cientos o
+miles de cambios, muchos de los cuales probablemente entren en conflicto
+con el trabajo que otros desarrolladores están realizando. No hace falta
+decir que esto puede ser un trabajo grande, por lo que es mejor asegurarse
+de que la justificación sea sólida. Tenga en cuenta que la herramienta
+Coccinelle puede ayudar con los cambios de API a gran escala.
+
+Cuando se realice un cambio incompatible en la API, siempre que sea
+posible, se debe asegurar que el código que no ha sido actualizado sea
+detectado por el compilador. Esto le ayudará a estar seguro de que ha
+encontrado todos los usos en el árbol de esa interfaz. También alertará a
+los desarrolladores de código fuera del árbol de que hay un cambio al que
+necesitan responder. Apoyar el código fuera del árbol no es algo de lo que
+los desarrolladores del kernel deban preocuparse, pero tampoco tenemos que
+dificultarles la vida más de lo necesario.
diff --git a/Documentation/translations/sp_SP/process/development-process.rst b/Documentation/translations/sp_SP/process/development-process.rst
index 8a967e569772..62ee4b2e109e 100644
--- a/Documentation/translations/sp_SP/process/development-process.rst
+++ b/Documentation/translations/sp_SP/process/development-process.rst
@@ -26,3 +26,4 @@ para entenderla.
    1.Intro
    2.Process
    3.Early-stage
+   4.Coding
-- 
2.43.0


