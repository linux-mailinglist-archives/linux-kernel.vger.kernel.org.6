Return-Path: <linux-kernel+bounces-281878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A053494DC6A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 13:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1D42B21AB3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 11:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A5D157495;
	Sat, 10 Aug 2024 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBOdvGcP"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA431B810;
	Sat, 10 Aug 2024 11:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723288551; cv=none; b=o67iXKqsrqnOEnx31w6EsuaD9KYLGqmXAIkPTqk3yZOk5aX4+rIePqQwD1AV1LMzkIWhsp05S1BSmc3K/mk3M8dx7ZFBmXgw0Gse5ZdGDj+pXkYgMW/6UAmyuLg+l6SP8r7u4pllk0rIChZZ0GOTu7sVZ+slkn/vTbju0MdoHls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723288551; c=relaxed/simple;
	bh=0kv0r7M0u9YFyPFmqEmX+BMvA+T7MYkAoNKr0znLjTk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=S5OrWMdz+LK0tZ1V2jgLEKuPVwlMolidZKhjssO9kD32iFrTLMP5xEXjvucXFxtW6ncdE+/MkUsNZwWE2YmooZJjWHI5aLpPYr/Y8WLmqe5xiUdMqMHVI1wgQrwk45idc0N9M290wYJ8JPBM+ONzpy1Q4hbhOx8RpXJEI03f+dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBOdvGcP; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so21184555e9.2;
        Sat, 10 Aug 2024 04:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723288548; x=1723893348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bnQ+KfMwxGUG7PiqOtodLq5r046+Ih8B8xbS6UwetXI=;
        b=LBOdvGcPIwYFypL3m0wuKewjcBXImMzirb6S5KuA7S42PVbynXYraDICHdcPgcPEGD
         8ioa128wHhoWEKSiOW8bOe7U99cKY69HYJ6mfajEhzVK2UGr9I4Sa/p9SNovz3ZktCHi
         jiU8FepzuYGciwy+v7eIS0LWavSL0SpLISs67LSHrSSuZAbnZ1zt/WQ4RWD9jBMSBC+d
         sPJgeUSzj3VQUQB1c2MCIIhIMW/3U5PkBeJZ39mIMika8CqlJpvfY2/JwDZT2F/kdkhM
         E4Je91ghkVvf1Us3jz3iqnL96a50oFaNvr6gC2+x9og8SxF7CB6oV3he4xtsSHsjWCa4
         97RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723288548; x=1723893348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bnQ+KfMwxGUG7PiqOtodLq5r046+Ih8B8xbS6UwetXI=;
        b=aIt97rhcBeGmkxAP2tXyUCYsuJgXFnvwIpKtUiN1ByXRm4iIfzw0BjkTL2xlkBMJBf
         ab4ZmtPFs0QXNVpbdFuo9AJSL09/YnIVkJMUF7xbjPpqAYNqPiLvneC8QmlQAERsQlaJ
         +dEjLkqeh/khDn2i3KISyvjsRP1zrXaScbhniW/6T47f9s95d7TfWKCYxjk+8swD9H2F
         8j3oPo2ecKkrtPsdA37Vn5FsQd2swijFSo0JU2UxUnqg80WQ1hKkkdelQsLDP5Gb9kZL
         kVUqZPAmHIhmnfi1Z3GN8ciJ3YYgi8in89qPsa+Rs5S1M2Pw+n78ItkwCb3KmjXVsR1b
         RTLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEMiTuvnAO5e5mEjRcoH1lMhSVFIE9NH2+G/ZhzRmhvzgPrVNo4tFrb9oEimEyP/Lr1u9pXLCVWv3/kdYvfHDvviZIcDVSLxxl2Ftj
X-Gm-Message-State: AOJu0Yy4EFIHG49N2wg6uMxhq5FjH2iiu/GBvmQRv3L6LQTi9WC23Rhv
	PkWrQxI8UDxnG7aW6K7FlCypz/Rix+1QDUOpxiOuHmhGLm1e2Gv3
X-Google-Smtp-Source: AGHT+IG/S5dBAVx5hOYBmsbAVXWyTT7ET+S2Xzwyd00AYBry/qByg5G7vocddhGT0j+kHi8CHSsQvQ==
X-Received: by 2002:a05:600c:3584:b0:428:fb7f:c831 with SMTP id 5b1f17b1804b1-429c3a5821amr34249335e9.32.1723288547759;
        Sat, 10 Aug 2024 04:15:47 -0700 (PDT)
Received: from laptop.. (117.red-83-52-251.dynamicip.rima-tde.net. [83.52.251.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c74ffd55sm26155245e9.4.2024.08.10.04.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 04:15:46 -0700 (PDT)
From: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
Subject: [PATCH v2] docs/sp_Sp: Add translation to spanish of the documentation related to EEVDF
Date: Sat, 10 Aug 2024 13:15:13 +0200
Message-Id: <20240810111513.20049-1-sergio.collado@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Translate Documentation/scheduler/sched-eevdf.rst to spanish.

Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
---
 v1 -> v2: correct the commit message.
---
 .../translations/sp_SP/scheduler/index.rst    |  1 +
 .../sp_SP/scheduler/sched-design-CFS.rst      |  8 +--
 .../sp_SP/scheduler/sched-eevdf.rst           | 58 +++++++++++++++++++
 3 files changed, 63 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/translations/sp_SP/scheduler/sched-eevdf.rst

diff --git a/Documentation/translations/sp_SP/scheduler/index.rst b/Documentation/translations/sp_SP/scheduler/index.rst
index 768488d6f001..32f9fd7517b2 100644
--- a/Documentation/translations/sp_SP/scheduler/index.rst
+++ b/Documentation/translations/sp_SP/scheduler/index.rst
@@ -6,3 +6,4 @@
     :maxdepth: 1
 
     sched-design-CFS
+    sched-eevdf
diff --git a/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst b/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst
index 90a153cad4e8..8b8eb581c7be 100644
--- a/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst
+++ b/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst
@@ -14,10 +14,10 @@ Gestor de tareas CFS
 
 CFS viene de las siglas en inglés de "Gestor de tareas totalmente justo"
 ("Completely Fair Scheduler"), y es el nuevo gestor de tareas de escritorio
-implementado por Ingo Molnar e integrado en Linux 2.6.23. Es el sustituto de
-el previo gestor de tareas SCHED_OTHER.
-
-Nota: El planificador EEVDF fue incorporado más recientemente al kernel.
+implementado por Ingo Molnar e integrado en Linux 2.6.23. Es el sustituto
+del previo gestor de tareas SCHED_OTHER. Hoy en día se está abriendo camino
+para el gestor de tareas EEVDF cuya documentación se puede ver en
+Documentation/scheduler/sched-eevdf.rst
 
 El 80% del diseño de CFS puede ser resumido en una única frase: CFS
 básicamente modela una "CPU ideal, precisa y multi-tarea" sobre hardware
diff --git a/Documentation/translations/sp_SP/scheduler/sched-eevdf.rst b/Documentation/translations/sp_SP/scheduler/sched-eevdf.rst
new file mode 100644
index 000000000000..54f68473f31a
--- /dev/null
+++ b/Documentation/translations/sp_SP/scheduler/sched-eevdf.rst
@@ -0,0 +1,58 @@
+
+.. include:: ../disclaimer-sp.rst
+
+:Original: :ref:`Documentation/scheduler/sched-eevdf.rst <sched_eevdf>`
+:Translator: Sergio González Collado <sergio.collado@gmail.com>
+
+======================
+Gestor de tareas EEVDF
+======================
+
+El gestor de tareas EEVDF,del inglés: "Earliest Eligible Virtual Deadline
+First", fue presentado por primera vez en una publicación científica en
+1995 [1]. El kernel de Linux comenzó a transicionar hacia EEVPF en la
+versión 6.6 (y como una nueva opción en 2024), alejándose del gestor
+de tareas CFS, en favor de una versión de EEVDF propuesta por Peter
+Zijlstra en 2023 [2-4]. Más información relativa a CFS puede encontrarse
+en Documentation/scheduler/sched-design-CFS.rst.
+
+De forma parecida a CFS, EEVDF intenta distribuir el tiempo de ejecución
+de la CPU de forma equitativa entre todas las tareas que tengan la misma
+prioridad y puedan ser ejecutables. Para eso, asigna un tiempo de
+ejecución virtual a cada tarea, creando un "retraso" que puede ser usado
+para determinar si una tarea ha recibido su cantidad justa de tiempo
+de ejecución en la CPU. De esta manera, una tarea con un "retraso"
+positivo, es porque se le debe tiempo de ejecución, mientras que una
+con "retraso" negativo implica que la tarea ha excedido su cuota de
+tiempo. EEVDF elige las tareas con un "retraso" mayor igual a cero y
+calcula un tiempo límite de ejecución virtual (VD, del inglés: virtual
+deadline) para cada una, eligiendo la tarea con la VD más próxima para
+ser ejecutada a continuación. Es importante darse cuenta que esto permite
+que la tareas que sean sensibles a la latencia que tengan porciones de
+tiempos de ejecución de CPU más cortos ser priorizadas, lo cual ayuda con
+su menor tiempo de respuesta.
+
+Ahora mismo se está discutiendo cómo gestionar esos "retrasos", especialmente
+en tareas que estén en un estado durmiente; pero en el momento en el que
+se escribe este texto EEVDF usa un mecanismo de "decaimiento" basado en el
+tiempo virtual de ejecución (VRT, del inglés: virtual run time). Esto previene
+a las tareas de abusar del sistema simplemente durmiendo brevemente para
+reajustar su retraso negativo: cuando una tarea duerme, esta permanece en
+la cola de ejecución pero marcada para "desencolado diferido", permitiendo
+a su retraso decaer a lo largo de VRT. Por tanto, las tareas que duerman
+por más tiempo eventualmente eliminarán su retraso. Finalmente, las tareas
+pueden adelantarse a otras si su VD es más próximo el tiempo, y las
+tareas podrán pedir porciones de tiempo específicas con la nueva llamada
+del sistema sched_setattr(), todo esto facilitara el trabajo en las aplicaciones
+que sean sensibles a las latencias.
+
+REFERENCIAS
+===========
+
+[1] https://citeseerx.ist.psu.edu/document?repid=rep1&type=pdf&doi=805acf7726282721504c8f00575d91ebfd750564
+
+[2] https://lore.kernel.org/lkml/a79014e6-ea83-b316-1e12-2ae056bda6fa@linux.vnet.ibm.com/
+
+[3] https://lwn.net/Articles/969062/
+
+[4] https://lwn.net/Articles/925371/
-- 
2.39.2


