Return-Path: <linux-kernel+bounces-281850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4088B94DC10
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 11:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AACE31F21DDE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 09:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9637B1514DC;
	Sat, 10 Aug 2024 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFDToBlR"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C49142E77;
	Sat, 10 Aug 2024 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723283039; cv=none; b=m71xxc1FnGJMjH05ZJzMUkSUfBvcgWmyTmETgYrXMxgWhAaxdxGTzEzcVeorDK6V8wZfjkHVmhUG2T8U6cE6Algo1TNUYS3SXOFGbEJBulvpa95CD+SVXk9wmQB7mDI95nd87XtHYuwmxrNeYnB4/ipbjMFXzsiTDcCQjDyy6OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723283039; c=relaxed/simple;
	bh=qqi7ZOwKwDTZ9Llrm0dom3gS+Cs5uBd+VaD8C+rprgA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ocutNqij87OrXtKS95VtGygU/xh1EKje61unb3l8T5lHmT5AwZizlkGc/sRKAdkhODfwQ6jPZynjcY3MiJRXZ0JFqLynZ7D7rTZDm4f1gCq9thCIJ0Ap/C/0aCrfE9hkuya4retinlmf124/Ip1GBFyWM9chpJHxX69Cq+kdIL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFDToBlR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42809d6e719so20703545e9.3;
        Sat, 10 Aug 2024 02:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723283036; x=1723887836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9lK3KNADF1A/NIXMtd/ommJFQkgG7/HTW72cQ/zXCQo=;
        b=jFDToBlR40YHdgRcwn3yeqqnb3eYkm3YIVxQB0hukXGkuT/D9v6H8pR7rB8IDf/GNH
         nEFtUaLg1OfMBHxzuH0lWpBXkd2YeRW5MlYIClY0yDULwRA+H3ya6H/3TduiA+TDIzYh
         /q4LpX74zj9FKPSMWiFcsqV+xeV4vVvUgfbHSWD7gkegWoieL3zvPdlbbo2+M2ldJ8Ya
         DUOAVhEsYVivRwW9zk5VKB7Yb+FoUOJ/Y1Z7eaMw3sIsAWwf48uiIHGM1sT1tz98qxC3
         rIJlKB5Xt8yP6Ji67DlVwayJWQCB8vDXm7afdiUBo8rcWPpSUpb+IeNxXM0ULl+XB2ms
         jy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723283036; x=1723887836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9lK3KNADF1A/NIXMtd/ommJFQkgG7/HTW72cQ/zXCQo=;
        b=g8iCRdIaQJhtB1/loNkoVTpLWv6FuwvVPvYfsYxHMW0KC822sWssv/V7X5cffx3jZC
         1rGT6D3H5Psp93aSCLhqrCC9Alvr3SCng+xxkH35xx0UxRpEGsJp9qId1+LMgEK0vkcW
         ldf5GlWpouKsYfnm6XHJWao904f7rZglMZKWIaDHGWq0O3AlcTgqNP6CzYZc6veaYizd
         n+LhXYdwNWLbhEaXQTQ9Er2+sQgkR/h89UPbfsYuGpYxitTauCs1VHI4RcX7dvKGFcYn
         TnbVOFTJC7v6uMjZnOQQwBPcbRVfidbJZQvbcrqk9Dvf7UBetn/qmor+kogWmzI5n5f9
         qIOg==
X-Forwarded-Encrypted: i=1; AJvYcCVjmZ4eRjWo9PPKHnHbanED0f0MrM+Vdr63JukLKRd+HXDz9SKlg+5T4wLlxZGTIt5ykTUINC0swi/gJrVC1jA4JBGaBqBYSUaHUV1w
X-Gm-Message-State: AOJu0YwsMoGTM6IjJZgMUYWgUPmAZ0FG91W1fZ//SnukcrGVyETHR04p
	jJYF55YrJc2CYmUDI9YvBMDlhIJpb/RPmyu+8ZYr4gn/nWes12xwaZzEFsgm
X-Google-Smtp-Source: AGHT+IE06kbupzMLYw8kuT9Ee/44ffgb7AjxSqU1c58oKTHHBOjsu555g5BH3E9BJI2LdYC/3oF1fQ==
X-Received: by 2002:a05:600c:568f:b0:428:2e9:65a9 with SMTP id 5b1f17b1804b1-429c3a52c4cmr29731335e9.28.1723283035422;
        Sat, 10 Aug 2024 02:43:55 -0700 (PDT)
Received: from laptop.. (117.red-83-52-251.dynamicip.rima-tde.net. [83.52.251.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c9ca1067sm8749065e9.1.2024.08.10.02.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 02:43:55 -0700 (PDT)
From: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
Subject: [PATCH] Translation to spanish of the documentation related to EEVDF
Date: Sat, 10 Aug 2024 11:43:47 +0200
Message-Id: <20240810094348.13745-1-sergio.collado@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
---
 .../translations/sp_SP/scheduler/index.rst    |  1 +
 .../sp_SP/scheduler/sched-design-CFS.rst      |  8 +--
 .../sp_SP/scheduler/sched-eevdf.rst           | 59 +++++++++++++++++++
 3 files changed, 64 insertions(+), 4 deletions(-)
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
index 000000000000..b49e202bf79a
--- /dev/null
+++ b/Documentation/translations/sp_SP/scheduler/sched-eevdf.rst
@@ -0,0 +1,59 @@
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
+
-- 
2.39.2


