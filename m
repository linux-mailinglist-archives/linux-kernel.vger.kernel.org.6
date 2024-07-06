Return-Path: <linux-kernel+bounces-243264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1D29293C2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 15:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF8BAB2116C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC3A7A15B;
	Sat,  6 Jul 2024 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efvmfBtK"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C2E482D3;
	Sat,  6 Jul 2024 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720272186; cv=none; b=epF8Gxt88rtcomVYAGbEnKLSbI4mD7TMQEW77lZbt959jzubVvwip7gUSz5KsZJryzEYOF6h45gZ0kfnGJ5YTzFQNKLZse4GzRJ/FUrS0830NN8RXrL9i2gW6pVlju0LolCbfewWepVunOp8VXpj0/VHWydFivuLXlFD5gVFdTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720272186; c=relaxed/simple;
	bh=Arqr2O+E26dOPVE/MiOy1W5JC9TdNFDPmY+8IKbx3l0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=g4+DSIJ+t6ppHd/sjrra9xqO9qDsTR3YSzntcht33+nFxQ9sJ1rWLwbjTqwO5JBOiARiIYDW2QvBDSD3kk+R2PLJrPQQEbZf7gBO3GloNjad8c/lwJSzRzzrAgU8s2wrjFDQ4I1bX6WYMyqgJuMtQFr5jx9GJ+YRrVP7U2MVd0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efvmfBtK; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36796a9b636so1773484f8f.2;
        Sat, 06 Jul 2024 06:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720272183; x=1720876983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HCG9bhtoXSHvRQi19xQn5JCPOGveVxUx3KcKQAi2HaE=;
        b=efvmfBtK77yF2+mPhmnSAZozx5WDmcMY4JtI3h7RaldxioVXmxNLFCNth0BwUQVG8X
         +t4WE/eKa0QYA4u39EQDI+QqEqEKwHB9msGPQLiuTXDRiUzBTc9ojv4KbsNF/xofp+EQ
         2PHHs/9uQiQLg5PoqWUiBtwFkeWzHY4rf6721TgmVP1gfjoV3p2u+P1dVqJ0qpoVTKDJ
         GO1EZ5erjoVLpfsHweoWy1ktI9VFfYfrkX8ypS+YmxcUsNLhcDpIGC9eF0kPNbfLwi0z
         dmh0r4ZywvUZrIh9oAuKEwpSRqLIt4E/PAv2FXs8X50GxWqmCf2EIWjBAZPFZtKFhdDW
         i50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720272183; x=1720876983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCG9bhtoXSHvRQi19xQn5JCPOGveVxUx3KcKQAi2HaE=;
        b=IhKG15SwgjJld13dgq1wOHjAV/9EhrNBxxpRiK29H6cYQiQO0LzZO7cTw27Qa3zszu
         15x7yev++uSqI8Nvvt4tSxXTpjGUpK0qisyMgBAOo7mF10pGmCOK1DyPDYTRmzm0KCx5
         LH+W1XpEPNEXDD/rk2lVGlkyw0KBdV8wc8+hLITqa+rdG/70wlnl5a1j/oCDwO9SLY3Z
         /+IVv4UWjhRFMqhosmNl/pu84NtLKTpCigcSxmmYwZmN8tyPc5R9T+89PFrPGx3cUspm
         Jp9WXOvG2BWfn7KQR8wogc02OrLPrOJLk4Z5rKI5G8Zb7HCayvhoA7LAW0iijmtGIdJm
         ANpg==
X-Forwarded-Encrypted: i=1; AJvYcCWC4c93MRnPK1R3CXOqzNqrsM2V04qLT29OoS5XITY4mw4cqxf5NijH1JUb2VWPfbJEqP44vd6++q20W5Qk1QyUqw63Z9LrujQuVaaJaWuszwmqfmHC1H7MGd+CIilyX5ia3DpURcM3
X-Gm-Message-State: AOJu0YwVBGE1JWsIrvyNFTQxz2s33EKc8wgC/uWUbl9d3V+30icgaKbL
	4Mui0lD6KTp982miJpY8ZEgMo8P5pegWFc47mnPF3gD1KZqnuh4B
X-Google-Smtp-Source: AGHT+IHpcaqmPXPT56Wm2B1lipm05Y/XcJ4NPvjFqSgSW0V4gLGrZftGZ9fDNoCxikIGPlYs89gRpQ==
X-Received: by 2002:a5d:4cc1:0:b0:365:b695:ef76 with SMTP id ffacd0b85a97d-3679dd34179mr4479510f8f.36.1720272182433;
        Sat, 06 Jul 2024 06:23:02 -0700 (PDT)
Received: from laptop.home (83.50.134.37.dynamic.jazztel.es. [37.134.50.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a25b724sm94886665e9.38.2024.07.06.06.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 06:23:02 -0700 (PDT)
From: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Ingo Molnar <mingo@kernel.org>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
	Wenyu Huang <huangwenyu5@huawei.com>
Cc: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bilbao@vt.edu,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
Subject: [PATCH] docs/sp_SP: Add translation for scheduler/sched-design-CFS.rst
Date: Sat,  6 Jul 2024 15:22:01 +0200
Message-Id: <20240706132201.26136-1-sergio.collado@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Translate Documentation/scheduler/sched-design-CFS.rst into Spanish

Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
---
 Documentation/scheduler/sched-design-CFS.rst  |   2 +
 Documentation/translations/sp_SP/index.rst    |   1 +
 .../translations/sp_SP/scheduler/index.rst    |   8 +
 .../sp_SP/scheduler/sched-design-CFS.rst      | 275 ++++++++++++++++++
 4 files changed, 286 insertions(+)
 create mode 100644 Documentation/translations/sp_SP/scheduler/index.rst
 create mode 100644 Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst

diff --git a/Documentation/scheduler/sched-design-CFS.rst b/Documentation/scheduler/sched-design-CFS.rst
index e030876fbd68..bc1e507269c6 100644
--- a/Documentation/scheduler/sched-design-CFS.rst
+++ b/Documentation/scheduler/sched-design-CFS.rst
@@ -1,3 +1,5 @@
+.. _sched_design_CFS:
+
 =============
 CFS Scheduler
 =============
diff --git a/Documentation/translations/sp_SP/index.rst b/Documentation/translations/sp_SP/index.rst
index 274ef4ad96b9..aae7018b0d1a 100644
--- a/Documentation/translations/sp_SP/index.rst
+++ b/Documentation/translations/sp_SP/index.rst
@@ -78,3 +78,4 @@ Traducciones al español
 
    process/index
    wrappers/memory-barriers
+   scheduler/index
diff --git a/Documentation/translations/sp_SP/scheduler/index.rst b/Documentation/translations/sp_SP/scheduler/index.rst
new file mode 100644
index 000000000000..768488d6f001
--- /dev/null
+++ b/Documentation/translations/sp_SP/scheduler/index.rst
@@ -0,0 +1,8 @@
+.. include:: ../disclaimer-sp.rst
+
+.. _sp_scheduler_index:
+
+.. toctree::
+    :maxdepth: 1
+
+    sched-design-CFS
diff --git a/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst b/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst
new file mode 100644
index 000000000000..43e29297d7fa
--- /dev/null
+++ b/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst
@@ -0,0 +1,275 @@
+.. include:: ../disclaimer-sp.rst
+
+:Original: :ref:`Documentation/scheduler/sched-design-CFS.rst <sched_design_CFS>`
+:Translator: Sergio González Collado <sergio.collado@gmail.com>
+
+.. _sp_sched_desing_CFS:
+
+====================
+Gestor de tareas CFS
+====================
+
+1.  VISIÓN GENERAL
+==================
+
+CFS viene de las siglas en inglés de "Gestor te tareas totalmente justo"
+("Completely Fair Scheduler"), y es el nuevo gestor de tareas de escritorio
+implementado por Ingo Molnar e integrado en Linux 2.6.23. Es el sustituto de
+el previo gestor de tareas SCHED_OTHER.
+
+El 80% del diseño de CFS puede ser resumido en una única frase: CFS
+básicamente modela una "CPU ideal, precisa y multi-tarea" sobre hardware
+real.
+
+"una CPU multitarea ideal" es una CPU (inexistente :-)) que tiene un 100%
+de potencia y que puede ejecutar cualquier tarea exactamente a la misma
+velocidad, en paralelo, y cada una a 1/n velocidad. Por ejemplo, si hay dos
+tareas ejecutándose, entonces cada una usa un 50% de la potencia --- es decir,
+como si se ejecutaran en paralelo.
+
+En un hardware real, se puede ejecutar una única tarea a la vez, así que
+se ha usado el concepto de "tiempo de ejecución virtual". El tiempo
+de ejecución virtual de una tarea, específica cuando la siguiente porción
+de ejecución podría empezar en la CPU ideal multi-tarea descrita anteriormente.
+En la práctica, el tiempo de ejecución virtual de una tarea es el
+tiempo de ejecución real normalizado con respecto al número total de
+tareas ejecutándose.
+
+
+2.  UNOS CUANTOS DETALLES DE IMPLEMENTACIÓN
+===========================================
+
+En CFS, el tiempo de ejecución virtual se expresa y se monitoriza por
+cada tarea, en su valor de p->se.vruntime (en unidades de nanosegundos).
+De este modo, es posible temporizar con precisión y medir el "tiempo
+de CPU esperado" que una tarea debería tener.
+
+Un pequeño detalle: en hardware "ideal", en cualquier momento todas las
+tareas pueden tener el mismo valor de p->se.vruntime --- i.e., tareas
+se podrían ejecutar simultáneamente y ninguna tarea podría escaparse del
+"balance" de la partición "ideal" del tiempo compartido de la CPU.
+
+La lógica de elección del tareas de CFS se basa en el valor de p->se.vruntime
+y por tanto es muy sencilla: siempre intenta ejecutar la tarea con el valor
+p->se.vruntime más pequeño (i.e., la tarea que se ha ejecutado menos hasta el
+momento). CFS siempre intenta dividir el espacio de tiempo entre tareas
+en ejecución tan próximo a la "ejecución multitarea ideal del hardware" como
+sea posible.
+
+El resto del diseño de CFS simplemente se escapa de este simple concepto,
+con unos cuantos añadidos como los niveles "nice" ("nice" significa "amable"
+en inglés), multi-tarea y varias variantes del algoritmo para identificar
+tareas "durmiendo".
+
+
+3.  EL ÁRBOL ROJO-NEGRO
+=======================
+
+El diseño de CFS es bastante radical: no utiliza las antiguas estructuras
+de datos para las colas de ejecución (en inglés "runqueues"), pero usa una
+estructura de árbol rojo-negro (en inglés "red-black tree") ordenado cronológicamente
+para construir un línea de ejecución en el futuro, y por eso no tiene ningún
+artificio de "cambio de tareas" (algo que previamente era usado por el gestor
+anterior y RSDL/SD).
+
+CFS también mantiene el valor de rq->cfs.min_vruntime, el cual crece
+monotónicamente siguiendo el valor más pequeño de vruntime de entre todas
+las tareas en la cola de ejecución. La cantidad total de trabajo realizado
+por el sistema es monitorizado usado min_vruntime; este valor es usado
+para situar las nuevas tareas en la parte izquierda del árbol tanto
+como sea posible.
+
+El valor total de tareas ejecutándose en la cola de ejecución es
+contabilizado mediante el valor rq->cfs.load, el cual es la suma de los
+de esas tareas que están en la cola de ejecución.
+
+CFS mantiene un árbol rojo-negro cronológiamente ordenado, donde todas las
+tareas que pueden ser ejecutadas están ordenadas por su valor de
+p->se.vruntime. CFS selecciona la tarea más hacia la izquierda de este
+árbol y la mantiene. Según el sistema continúa, las tareas ejecutadas
+se ponen en este árbol más y más hacia la derecha --- lentamente pero
+de forma continuada dando una oportunidad a cada tarea de ser la que
+está "la más hacia la izquierda" y por tanto obtener la CPU una cantidad
+determinista de tiempo.
+
+Resumiendo, CFS funciona así: ejecuta una tarea un tiempo, y cuando la
+tarea se gestiona (o sucede un tic del gestor de tareas) se considera
+que el tiempo de uso de la CPU se ha completado, y se añade a
+p->se.vruntime. Una vez p->se.vruntime ha aumentado lo suficiente como
+para que otra tarea sea "la tarea más hacia la izquierda" del árbol
+rojo-negro ordenado cronológicamente esta mantienen (más una cierta pequeña
+cantidad de distancia relativa a la tarea más hacia la izquierda para
+que no se sobre-reserven tareas y perjudique a la cache), entonces la
+nueva tarea "que está a la izquierda del todo", es la que se elige
+para que se ejecute, y la tarea en ejecución es interrumpida.
+
+4.  ALGUNAS CARACTERÍSTICAS DE CFS
+==================================
+
+CFS usa una granularidad de nanosegundos y no depende de ningún
+jiffie o detalles como HZ. De este modo el gestor de tareas CFS no tiene
+noción de "ventanas de tiempo" de la forma en que tenía el gestor de
+tareas previo, y tampoco tiene heurísticos. Únicamente hay un parámetro
+central ajustable (se ha de cambiar en CONFIG_SCHED_DEBUG):
+
+   /sys/kernel/debug/sched/base_slice_ns
+
+El cual puede ser usado para afinar desde el gestor de tareas del "escritorio"
+(i.e., bajas latencias) hacia cargas de "servidor" (i.e., bueno con
+procesamientos). Su valor por defecto es adecuado para tareas de escritorio.
+SCHED_BATCH también es gestionado por el gestor de tareas CFS.
+
+Debido a su diseño, el gestor de tareas CFS no es proclive a ninguno de los
+ataques que existen a día de hoy contra los heurísticos del gestor de tareas:
+fiftyp.c, thud.c, chew.c, ring-test.c, massive_intr.c todos trabajan
+correctamente y no tienen impacto en la interacción y se comportan de la forma
+esperada.
+
+El gestor de tareas CFS tiene una gestión mucho más firme de los niveles
+"nice" y SCHED_BATCH que los previos gestores de tareas: ambos tipos de
+tareas están aisladas de forma más eficiente.
+
+El balanceo de tareas SMP ha sido rehecho/mejorado: el avance por las
+colas de ejecución de tareas ha desaparecido del código de balanceo de
+carga, y ahora se usan iteradores en la gestión de módulos. El balanceo
+del código ha sido simplificado como resultado esto.
+
+5.  Políticas de gestión de tareas
+==================================
+
+CFS implementa tres políticas de gestión de tareas:
+
+  - SCHED_NORMAL (tradicionalmente llamada SCHED_OTHER): Gestión de
+    tareas que se usan para tareas normales.
+
+  - SCHED_BATCH: No interrumpe tareas tan amenudo como las tareas
+    normales harían, por eso permite a las tareas ejecutarse durante
+    ventanas de tiempo mayores y hace un uso más efectivo de las
+    caches pero al coste de la interactividad. Esto es adecuado
+    para trabajos de procesado de datos.
+
+  - SCHED_IDLE: Esta política es más débil incluso que nice 19, pero
+    no es un gestor "idle" para evitar caer en el problema de la
+    inversión de prioridades que causaría un bloqueo de la máquina
+    (deadlock).
+
+SCHED_FIFO/_RR se implementan en sched/rt.c y son específicos de
+POSIX.
+
+El comando chrt de util-linux-ng 2.13.1.1. puede asignar cualquiera de
+estas políticas excepto SCHED_IDLE.
+
+
+6.  CLASES DE GESTIÓN
+=====================
+
+El nuevo gestor de tareas CFS ha sido diseñado de tal modo para incluir
+"clases de gestión", una jerarquía ampliable de módulos que pueden tener
+distintas políticas de gestión de tareas. Estos módulos encapsulan los
+detalles de las politicas de gestion y son manejadas por el núcleo del
+gestor de tareas sin que este tenga que presuponer mucho sobre estas clases.
+
+sched/fair.c implementa el gestor de tareas CFS descrito arriba.
+
+sched/rt.c implementa la semántica de SCHED_FIFO y SCHED_RR, de una forma
+más sencilla que el gestor de tareas anterior. Usa 100 colas de ejecución
+(por todos los 100 niveles de prioridad RT, en vez de las 140 que necesitaba
+el gestor de tareas anterior) y no necesita las listas de expiración.
+
+Las clases de gestión de tareas son implementadas por medio de la estructura
+sched_class, la cual tiene llamadas a las funciones que deben de llamarse
+cuando quiera que ocurra un evento interesante.
+
+Esta es la lista parcial de llamadas:
+
+ - enqueue_task(...)
+
+   Llamada cuando una tarea entra en el estado de lista para ejecución.
+   Pone la entidad a ser gestionada (la tarea) en el árbol rojo-negro
+   e incrementa la variable nr_running.
+
+ - dequeue_task(...)
+
+   Cuando una tarea deja de ser ejecutable, esta función se llama para
+   mantener a la entidad gestionada fuera del árbol rojo-negor. Esto
+   decrementa la variable nr_running.
+
+ - yield_task(...)
+
+   Esta función es básicamente desencolar, seguido por encolar, a menos que
+   sysctl compat_yield esté activado; en ese caso, sitúa la entidad a gestionar
+   en la parte más hacia la derecha del árbol rojo-negro.
+
+ - check_preempt_curr(...)
+
+   Esta función comprueba si una tarea que ha entrado en el estado de
+   poder ser ejecutada, podría reemplazar a la tarea que actualmente
+   se esté ejecutando.
+
+ - pick_next_task(...)
+
+   Esta función elige la tarea más apropiada para ser ejecutada a continuación.
+
+ - set_curr_task(...)
+
+   Esta función se llama cuando una tarea cambia su clase de gestión o
+   cambia su grupo de tareas.
+
+ - task_tick(...)
+
+   Esta función es llamada la mayoría de las veces desde la función de tiempo
+   tick; esto puede llevar a un cambio de procesos. Esto dirige el reemplazo
+   de las tareas.
+
+
+7.  EXTENSIONES DE GRUPOS PARA CFS
+==================================
+
+Normalmente, el gestor de tareas gestiona tareas individuales e intenta
+proporcionar una cantidad justa de CPU a cada tarea. Algunas veces, puede
+ser deseable agrupar las tareas y proporcionarles una cantidad justa
+de tiempo de CPU a cada una de las tareas de ese grupo. Por ejemplo,
+podría ser deseable que primero se proporcione una cantidad justa de
+tiempo de CPU a cada usuario del sistema y después a cada tarea
+que pertenezca a un usuario.
+
+CONFIG_CGROUP_SCHED destaca en conseguir exactamente eso. Permite a las
+tareas ser agrupadas y divide el tiempo de CPU de forma just entre esos
+grupos.
+
+CONFIG_RT_GROUP_SCHED permite agrupar tareas de tiempo real (i.e.,
+SCHED_FIFO y SCHED_RR).
+
+CONFIG_FAIR_GROUP_SCHED permite agrupar tareas de CFS (i.e., SCHED_NORMAL y
+SCHED_BATCH).
+
+Estas opciones necesitan CONFIG_CGROUPS para ser definidas, y permitir
+al administrador crear grupos arbitrarios de tareas, usando el pseudo
+sistema de archivos "cgroup". Vease la documentación para más información
+sobre este sistema de archivos: Documentation/admin-guide/cgroup-v1/cgroups.rst
+
+Cuando CONFIG_FAIR_GROUP_SCHED es definido, un archivo
+"cpu.shares" es creado por cada grupo creado usado en el pseudo
+sistema de archivos. Véanse por ejemplo los pasos a continuación
+para crear grupos de tareas y modificar cuanto comparten de la CPU
+usando el pseudo sistema de archivos "cgroup" ::
+
+	# mount -t tmpfs cgroup_root /sys/fs/cgroup
+	# mkdir /sys/fs/cgroup/cpu
+	# mount -t cgroup -ocpu none /sys/fs/cgroup/cpu
+	# cd /sys/fs/cgroup/cpu
+
+	# mkdir multimedia	# crear un grupo de tareas "multimedia"
+	# mkdir browser 	# crear un grupo de tareas "browser"
+
+	# #Configurar el grupo multimedia para tener el doble de tiempo de CPU
+	# #que el grupo browser
+
+	# echo 2048 > multimedia/cpu.shares
+	# echo 1024 > browser/cpu.shares
+
+	# firefox &	# Lanzar firefox y moverlo al grupo "browser"
+	# echo <firefox_pid> > browser/tasks
+
+	# #Lanzar gmplayer (o su programa favorito de reproducción de películas)
+	# echo <movie_player_pid> > multimedia/tasks
-- 
2.39.2


