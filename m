Return-Path: <linux-kernel+bounces-281858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8021194DC30
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 12:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34AD1C21112
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 10:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CB9153BFC;
	Sat, 10 Aug 2024 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQrYOoWM"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA09B182B3;
	Sat, 10 Aug 2024 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723284613; cv=none; b=cfRz33NCJD3a8K6yMYh7+J43rW5l/4goy8bFcmY8wAJYPOaGhkA0OAuhLTsfEvpDhVkEdQ1OgY/KpgItVxkYHfsgSOADZ8pTyqftapNJkhCgT8dI9RAFlZoBGv46QroOTlIlqSwWMlFZ9q5jtIi1N8eb+E8rCnMFg2+VJjWSbLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723284613; c=relaxed/simple;
	bh=FozgqAqsV9AfGatMUbFMh3AeCsad4eoVWnIQ29u1RLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gEbNBqxl0b4I8NIdWG09yVdMDuZbyoYYNoCn89UT3tx1pAUsq5bNGoErjh8ELIh34ps/nU13Pz3+01V8CUx+5EZSLlWZKYEq8mMjzZ9j5QDODJsz35adFxZPSGoqHPEGCFQ/k/mDtL4KQR9JBtMw2cvV4ccd1l8zwATRGXbjhMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQrYOoWM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428178fc07eso18823395e9.3;
        Sat, 10 Aug 2024 03:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723284610; x=1723889410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uzm1ViTlvvMr3QTzeVkc2Asr4wTxPuKRSgPRgd0aNNc=;
        b=dQrYOoWMyfRRG31YZGE6OODr+pwax5v8H+DgeGEW0PJSH0/OmmuEdsXP07JU7UZKON
         l0TcXp/ir8hyWRecCTUvQm3TfwGh6UY32/EthhQz9XFqZMTkAXhIIU4KeMyutGOQ0Iox
         zlqa0JthCd0AeuOM/mCMbvzMkvJTazaESG4giOMxQXJMEkmYUR0zVjn0NxKA3SGO7jvr
         7IbOz0+xtOybMon9JpAvjWXwqmnx6EYkIGmiyET+VisnVlmlyXv0yK1C13DSqdFMWGZV
         16u2wdKsXKEtKRVeRcTuIotUHSpDDnlOKG7Eaf57tzF07d18U5KwrcjuMnB2ENvgzwGf
         DGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723284610; x=1723889410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uzm1ViTlvvMr3QTzeVkc2Asr4wTxPuKRSgPRgd0aNNc=;
        b=VJgOKb8RPHgM8wex0x36YJEIvvOJFR64GJL9oxezFsLXafJdLD89ER1hxYBdH+M+Tg
         3qTn677RuFsWILFLxvqWmBenvwzAregYvHmKWPpXkoWXbtJtkpyQEzzZwa54Es7tsSnm
         KtIMnGRkGOkMvxca+lgMYoeOygEoX4h9gknNLNlqYXCIGJzt+rG32EAITk6TZZ/gT3ZT
         L0sjjt4wFxULqtdAoc1MfkVrP0rP5H0cxpnmygvZ6NsN7zw4ChtQIjcCaUe8VfNkODrJ
         dwc+4k28lewZjkc/Hl9SqR/4w+gnX2OAqtFHkeFULmGugHMe4UVf2KAAh+Q8SGSMkKWW
         msgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZUnBrWH7oM+YED0el12WBnZ0ioMDnMYo6yjj+SLErwjUjtoR5CrVe7IQ+T2kWatxlJcWn7kXTiWd7ijchwKvHgJJ3YQeiS6dfBKAO
X-Gm-Message-State: AOJu0Yzvbgn+yYw2gLcEfY9N19heKb14nKQeTtO56iNSkdYYPUmaEVI0
	KSh83G4/DR2TEUqhpzxuGptIgIp+40ZuYIQWRMSYAvFgpRZCj2zTZeZYXyPr
X-Google-Smtp-Source: AGHT+IGqBNT6WWYMMvj58QdRoIEZrYFHwdqZ1ETY5ytkXFpwlf8B5rQsEt2F4rXmimwckxr8p79Y2g==
X-Received: by 2002:a05:600c:310d:b0:427:d8f7:b718 with SMTP id 5b1f17b1804b1-429c3a51e0bmr28732775e9.24.1723284609478;
        Sat, 10 Aug 2024 03:10:09 -0700 (PDT)
Received: from laptop.. (117.red-83-52-251.dynamicip.rima-tde.net. [83.52.251.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c775c509sm23990445e9.44.2024.08.10.03.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 03:10:08 -0700 (PDT)
From: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
Subject: [PATCH v3] docs/sp_SP: Add translation for scheduler/sched-bwc.rst
Date: Sat, 10 Aug 2024 12:09:55 +0200
Message-Id: <20240810100955.14901-1-sergio.collado@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Translate Documentation/scheduler/sched-bwc.rst into Spanish.

Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
---
v1 -> v2 typos corrected
---
v2 -> v3 typos corrected
---
 .../translations/sp_SP/scheduler/index.rst    |   1 +
 .../sp_SP/scheduler/sched-bwc.rst             | 288 ++++++++++++++++++
 2 files changed, 289 insertions(+)
 create mode 100644 Documentation/translations/sp_SP/scheduler/sched-bwc.rst

diff --git a/Documentation/translations/sp_SP/scheduler/index.rst b/Documentation/translations/sp_SP/scheduler/index.rst
index 768488d6f001..3aef47ca87e0 100644
--- a/Documentation/translations/sp_SP/scheduler/index.rst
+++ b/Documentation/translations/sp_SP/scheduler/index.rst
@@ -6,3 +6,4 @@
     :maxdepth: 1
 
     sched-design-CFS
+    sched-bwc
diff --git a/Documentation/translations/sp_SP/scheduler/sched-bwc.rst b/Documentation/translations/sp_SP/scheduler/sched-bwc.rst
new file mode 100644
index 000000000000..ee9b34673560
--- /dev/null
+++ b/Documentation/translations/sp_SP/scheduler/sched-bwc.rst
@@ -0,0 +1,288 @@
+.. include:: ../disclaimer-sp.rst
+
+:Original: :ref:`Documentation/scheduler/sched-design-CFS.rst <sched_design_CFS>`
+:Translator: Sergio González Collado <sergio.collado@gmail.com>
+
+.. _sp_sched_bwc:
+
+=================================
+CFS con control de ancho de banda
+=================================
+
+.. note::
+   Este documento únicamente trata el control de ancho de banda de CPUs
+   para SCHED_NORMAL. El caso de SCHED_RT se trata en Documentation/scheduler/sched-rt-group.rst
+
+El control de ancho de banda es una extensión CONFIG_FAIR_GROUP_SCHED que
+permite especificar el máximo uso disponible de CPU para un grupo o una jerarquía.
+
+El ancho de banda permitido para un grupo de tareas se especifica usando una
+cuota y un periodo. Dentro de un "periodo" (microsegundos), a un grupo
+de tareas se le asigna hasta su "cuota" de tiempo de uso de CPU en
+microsegundos. Esa cuota es asignada para cada CPU en colas de ejecución
+en porciones de tiempo de ejecución en la CPU según los hilos de ejecución
+del grupo de tareas van siendo candidatos a ejecutarse. Una vez toda la cuota
+ha sido asignada cualquier petición adicional de cuota resultará en esos hilos
+de ejecución siendo limitados/estrangulados. Los hilos de ejecución limitados,
+no serán capaces de ejecutarse de nuevo hasta el siguiente periodo cuando
+la cuota sea restablecida.
+
+La cuota sin asignar de un grupo es monitorizada globalmente, siendo
+restablecidas cfs_quota unidades al final de cada periodo. Según los
+hilos de ejecución van consumiendo este ancho de banda, este se
+transfiere a los "silos" de las cpu-locales en base a la demanda. La
+cantidad transferida en cada una de esas actualizaciones es ajustable y
+es descrito como un "slice".
+
+Característica de ráfaga
+--------------------------
+
+Esta característica toma prestado tiempo ahora, que en un futuro tendrá que
+devolver, con el coste de una mayor interferencia hacia los otros usuarios
+del sistema. Todo acotado perfectamente.
+
+El tradicional control de ancho de banda (UP-EDF) es algo como:
+
+  (U = \Sum u_i) <= 1
+
+Esto garantiza dos cosas: que cada tiempo límite de ejecución es cumplido
+y que el sistema es estable. De todas formas, si U fuese > 1, entonces
+por cada segundo de tiempo de reloj de una tarea, tendríamos que
+ejecutar más de un segundo de tiempo de ejecución de programa, y
+obviamente no se cumpliría con el tiempo límite de ejecución de la
+tarea, pero en el siguiente periodo de ejecución el tiempo límite de
+la tarea estaría todavía más lejos, y nunca se tendría tiempo de alcanzar
+la ejecución, cayendo así en un fallo no acotado.
+
+La característica de ráfaga implica el trabajo de una tarea no siempre
+consuma totalmente la cuota; esto permite que se pueda describir u_i
+como una distribución estadística.
+
+Por ejemplo, se tiene u_i = {x,e}_i, donde x es el p(95) y x+e p(100)
+(el tradicional WCET (WCET:Worst Case Execution Time: son las siglas
+en inglés para "peor tiempo de ejecución")). Esto efectivamente permite
+a u ser más pequeño, aumentando la eficiencia (podemos ejecutar más
+tareas en el sistema), pero al coste de perder el instante límite de
+finalización deseado de la tarea, cuando coincidan las peores
+probabilidades. De todas formas, si se mantiene la estabilidad, ya que
+cada sobre-ejecución se empareja con una infra-ejecución en tanto x esté
+por encima de la media.
+
+Es decir, supóngase que se tienen 2 tareas, ambas específicamente
+con p(95), entonces tenemos p(95)*p(95) = 90.25% de probabilidad de
+que ambas tareas se ejecuten dentro de su cuota asignada y todo
+salga bien. Al mismo tiempo se tiene que p(5)*p(5) = 0.25% de
+probabilidad que ambas tareas excedan su cuota de ejecución (fallo
+garantizado de su tiempo final de ejecución). En algún punto por
+en medio, hay un umbral donde una tarea excede su tiempo límite de
+ejecución y la otra no, de forma que se compensan; esto depende de la
+función de probabilidad acumulada específica de la tarea.
+
+Al mismo tiempo, se puede decir que el peor caso de sobrepasar el
+tiempo límite de ejecución será \Sum e_i; esto es una retraso acotado
+(asumiendo que x+e es de hecho el WCET).
+
+La interferencia cuando se usa una ráfaga se evalúa por las posibilidades
+de fallar en el cumplimiento del tiempo límite y el promedio de WCET.
+Los resultados de los tests han mostrado que cuando hay muchos cgroups o
+una CPU está infrautilizada, la interferencia es más limitada. Más detalles
+se aportan en: https://lore.kernel.org/lkml/5371BD36-55AE-4F71-B9D7-B86DC32E3D2B@linux.alibaba.com/
+
+Gestión:
+--------
+
+Cuota, periodo y ráfaga se se gestionan dentro del subsistema de cpu por medio
+de cgroupfs.
+
+.. note::
+   Los archivos cgroupfs descritos en esta sección solo se aplican a el
+   cgroup v1. Para cgroup v2, ver :ref:`Documentation/admin-guide/cgroup-v2.rst <cgroup-v2-cpu>`.
+
+- cpu.cfs_quota_us: tiempo de ejecución que se refresca cada periodo (en microsegundos)
+- cpu.cfs_period_us: la duración del periodo (en microsegundos)
+- cpu.stat: exporta las estadísticas de limitación [explicado a continuación]
+- cpu.cfs_burst_us: el máximo tiempo de ejecución acumulado (en microsegundos)
+
+Los valores por defecto son::
+
+	cpu.cfs_period_us=100ms
+	cpu.cfs_quota_us=-1
+	cpu.cfs_burst_us=0
+
+Un valor de -1 para cpu.cfs_quota_us indica que el grupo no tiene ninguna
+restricción de ancho de banda aplicado, ese grupo se describe como un grupo
+con ancho de banda sin restringir. Esto representa el comportamiento
+tradicional para CFS.
+
+Asignar cualquier valor (válido) y positivo no menor que cpu.cfs_burst_us
+definirá el límite del ancho de banda. La cuota mínima permitida para
+la cuota o periodo es 1ms. Hay también un límite superior en la duración del
+periodo de 1s. Existen restricciones adicionales cuando los límites de
+ancho de banda se usan de manera jerárquica, estos se explican en mayor
+detalle más adelante.
+
+Asignar cualquier valor negativo a cpu.cfs_quota_us eliminará el límite de
+ancho de banda y devolverá de nuevo al grupo a un estado sin restricciones.
+
+Un valor de 0 para cpu.cfs_burst_us indica que el grupo no puede acumular
+ningún ancho de banda sin usar. Esto hace que el control del comportamiento
+tradicional del ancho de banda para CFS no cambie. Definir cualquier valor
+(válido) positivo no mayor que cpu.cfs_quota_us en cpu.cgs_burst_us definirá
+el límite con el ancho de banda acumulado no usado.
+
+Cualquier actualización a las especificaciones del ancho de banda usado
+por un grupo resultará en que se deje de limitar si está en un estado
+restringido.
+
+Ajustes globales del sistema
+----------------------------
+
+Por eficiencia el tiempo de ejecución es transferido en lotes desde una reserva
+global y el "silo" de una CPU local. Esto reduce en gran medida la presión
+por la contabilidad en grandes sistemas. La cantidad transferida cada vez
+que se requiere una actualización se describe como "slice".
+
+Esto es ajustable vía procfs::
+
+	/proc/sys/kernel/sched_cfs_bandwidth_slice_us (valor por defecto=5ms)
+
+Valores de "slice" más grandes reducirán el costo de transferencia, mientras
+que valores más pequeños permitirán un control más fino del consumo.
+
+Estadísticas
+------------
+
+Las estadísticas del ancho de banda de un grupo se exponen en 5 campos en cpu.stat.
+
+cpu.stat:
+
+- nr_periods: Número de intervalos aplicados que han pasado.
+- nr_throttled: Número de veces que el grupo ha sido restringido/limitado.
+- throttled_time: La duración de tiempo total (en nanosegundos) en las
+  que las entidades del grupo han sido limitadas.
+- nr_bursts: Número de periodos en que ha ocurrido una ráfaga.
+- burst_time: Tiempo acumulado (en nanosegundos) en la que una CPU ha
+  usado más de su cuota en los respectivos periodos.
+
+Este interfaz es de solo lectura.
+
+Consideraciones jerárquicas
+---------------------------
+
+El interfaz refuerza que el ancho de banda de una entidad individual
+sea siempre factible, esto es: max(c_i) <= C. De todas maneras,
+la sobre-suscripción en el caso agregado está explícitamente permitida
+para hacer posible semánticas de conservación de trabajo dentro de una
+jerarquia.
+
+  e.g. \Sum (c_i) puede superar C
+
+[ Donde C es el ancho de banda de el padre, y c_i el de su hijo ]
+
+Hay dos formas en las que un grupo puede ser limitado:
+
+        a. este consume totalmente su propia cuota en un periodo.
+        b. la cuota del padre es consumida totalmente en su periodo.
+
+En el caso b) anterior, incluso si el hijo pudiera tener tiempo de
+ejecución restante, este no le será permitido hasta que el tiempo de
+ejecución del padre sea actualizado.
+
+Advertencias sobre el CFS con control de cuota de ancho de banda
+----------------------------------------------------------------
+
+Una vez una "slice" se asigna a una cpu esta no expira. A pesar de eso todas,
+excepto las "slices" menos las de 1ms, puede ser devueltas a la reserva global
+si todos los hilos en esa cpu pasan a ser no ejecutables. Esto se configura
+en el tiempo de compilación por la variable min_cfs_rq_runtime. Esto es un
+ajuste en la eficacia que ayuda a prevenir añadir bloqueos en el candado global.
+
+El hecho de que las "slices" de una cpu local no expiren tiene como resultado
+algunos casos extremos interesantes que debieran ser comprendidos.
+
+Para una aplicación que es un cgroup y que está limitada en su uso de cpu
+es un punto discutible ya que de forma natural consumirá toda su parte
+de cuota así como también la totalidad de su cuota en cpu locales en cada
+periodo. Como resultado se espera que nr_periods sea aproximadamente igual
+a nr_throttled, y que cpuacct.usage se incremente aproximadamente igual
+a cfs_quota_us en cada periodo.
+
+Para aplicaciones que tienen un gran número de hilos de ejecución y que no
+estan ligadas a una cpu, este matiz de la no-expiración permite que las
+aplicaciones brevemente sobrepasen su cuota límite en la cantidad que
+no ha sido usada en cada cpu en la que el grupo de tareas se está ejecutando
+(típicamente como mucho 1ms por cada cpu o lo que se ha definido como
+min_cfs_rq_runtime). Este pequeño sobreuso únicamente tiene lugar si
+la cuota que ha sido asignada a una cpu y no ha sido completamente usada
+o devuelta en periodos anteriores. Esta cantidad de sobreuso no será
+transferida entre núcleos. Como resultado, este mecanismo todavía cumplirá
+estrictamente los límites de la tarea de grupo en el promedio del uso,
+pero sobre una ventana de tiempo mayor que un único periodo. Esto
+también limita la habilidad de un sobreuso a no más de 1ms por cada cpu.
+Esto provee de una experiencia de uso más predecible para aplicaciones
+con muchos hilos y con límites de cuota pequeños en máquinas con muchos
+núcleos. Esto también elimina la propensión a limitar estas
+aplicaciones mientras que simultáneamente usan menores cuotas
+de uso por cpu. Otra forma de decir esto es que permitiendo que
+la parte no usada de una "slice" permanezca válida entre periodos
+disminuye la posibilidad de malgastare cuota que va a expirar en
+las reservas de la cpu locales que no necesitan una "slice" completa
+de tiempo de ejecución de cpu.
+
+La interacción entre las aplicaciones ligadas a una CPU y las que no están
+ligadas a ninguna cpu ha de ser también considerada, especialmente cuando
+un único núcleo tiene un uso del 100%. Si se da a cada una de esas
+aplicaciones la mitad de la capacidad de una CPU-núcleo y ambas
+están gestionadas en la misma CPU es teóricamente posible que la aplicación
+no ligada a ninguna CPU use su 1ms adicional de cuota en algunos periodos,
+y por tanto evite que la aplicación ligada a una CPU pueda usar su
+cuota completa por esa misma cantidad. En esos caso el algoritmo CFS (vea
+sched-design-CFS.rst) el que decida qué aplicación es la elegida para
+ejecutarse, ya que ambas serán candidatas a ser ejecutadas y tienen
+cuota restante. Esta discrepancia en el tiempo de ejecución se compensará
+en los periodos siguientes cuando el sistema esté inactivo.
+
+Ejemplos
+---------
+
+1. Un grupo limitado a 1 CPU de tiempo de ejecución.
+
+    Si el periodo son 250ms y la cuota son 250ms el grupo de tareas tendrá el tiempo
+    de ejecución de 1 CPU cada 250ms::
+
+	# echo 250000 > cpu.cfs_quota_us /* cuota = 250ms */
+	# echo 250000 > cpu.cfs_period_us /* periodo = 250ms */
+
+2. Un grupo limitado al tiempo de ejecución de 2 CPUs en una máquina varias CPUs.
+
+    Con un periodo de 500ms y una cuota de 1000ms el grupo de tareas tiene el tiempo
+    de ejecución de 2 CPUs cada 500ms::
+
+	# echo 1000000 > cpu.cfs_quota_us /* cuota = 1000ms */
+	# echo 500000 > cpu.cfs_period_us /* periodo = 500ms */
+
+    El periodo más largo aquí permite una capacidad de ráfaga mayor.
+
+3. Un grupo limitado a un 20% de 1 CPU.
+
+    Con un periodo de 50ms, 10ms de cuota son equivalentes al 20% de 1 CPUs::
+
+	# echo 10000 > cpu.cfs_quota_us /* cuota = 10ms */
+	# echo 50000 > cpu.cfs_period_us /* periodo = 50ms */
+
+    Usando un periodo pequeño aquí nos aseguramos una respuesta de
+    la latencia consistente a expensas de capacidad de ráfaga.
+
+4. Un grupo limitado al 40% de 1 CPU, y permite acumular adicionalmente
+   hasta un 20% de 1 CPU.
+
+    Con un periodo de 50ms, 20ms de cuota son equivalentes al 40% de
+    1 CPU. Y 10ms de ráfaga, son equivalentes a un 20% de 1 CPU::
+
+	# echo 20000 > cpu.cfs_quota_us /* cuota = 20ms */
+	# echo 50000 > cpu.cfs_period_us /* periodo = 50ms */
+	# echo 10000 > cpu.cfs_burst_us /* ráfaga = 10ms */
+
+    Un ajuste mayor en la capacidad de almacenamiento (no mayor que la cuota)
+    permite una mayor capacidad de ráfaga.
+
-- 
2.39.2


