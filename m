Return-Path: <linux-kernel+bounces-299987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FE295DD42
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 11:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F5A28200F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 09:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3924115574A;
	Sat, 24 Aug 2024 09:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blqP90id"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CE08F6B;
	Sat, 24 Aug 2024 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724493268; cv=none; b=WE/S+PcWWVBWK5ZeWO/epoFf89Se0B4GwTHS6q3YHEEiXJs9yhtfBNT7NhCgGKYKUjDqwxUtRak86t8Br0HOaIyXfo7ny2har1yb3AS+SX4436ZzejiSqy3VbRUDExxDcvwwbPMoFdJrcuC+VyZv63BkkyIgs7UW/h1qQjNVVZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724493268; c=relaxed/simple;
	bh=RT4PAz5DWmaRViU89CTu1N1YNxLCpcJ/9YgA8TxWqsA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JCwRgMgC5mMHmMBZxeI6p4qBNnfdehHzgnkyzwsrNHOW/l3fcQIIFi1FqoUZ3HEVCfnyJ+yQzmKrxEcOPHdH1qnKNk0XZzkU8+RDMo+BeuCWj0TFmKyW+QKS7vWGswlyHXciNJgEivZl6snChp+lm7EU+K0vmCtbrmPA9DRtBUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blqP90id; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-428ec6c190eso22199485e9.1;
        Sat, 24 Aug 2024 02:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724493265; x=1725098065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zl/9QirrjmP00deE5lv+kl0ShCaSSoObNFIAo4Gu3To=;
        b=blqP90id7Tfx88hbXVuiEL0MH0JPaGFh42Il3dzPPGdJ7KtiESw2eHDejM5brCO1nb
         Lq5V9z7y1DoNin80rwwlKai0x63CXOJg9VyisA+NxyM5z+kzVPjArVbeOFbGR1As7BPu
         b/i2plTV49liJfzG3rvXcIdXA20WLpatlKXxLEywuC7uTZSsucIz91NtIYiAF3pKgc36
         yD76QawCQR+D2mXOysdyJflxx5O4jUvEtr4/qHngmnNDsk0MjQggBH0SCqA0uPSey02G
         3enuivx9lQQt6/f7Jyyrj8fnF4btq5sjVCPFFqSGmUVQp32ZCHMwyA+Wy472QR6e7OeW
         MAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724493265; x=1725098065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zl/9QirrjmP00deE5lv+kl0ShCaSSoObNFIAo4Gu3To=;
        b=hVoYefx/MLoSPGFmzaJ5D/9ZT3ArO3tyLvSCHIGfNN3zQpiQwut0g0etfpn4f7AnwR
         7R4it8fxnSIFdtESRz8Im78EDvtUaUWlH6olfDKya/TrWJuLwdFOPH9xRZOFIHgkWKkF
         j14P1nG/YDBbLz9slJACN3IC29X5nQhnqgVg5gPzsRafCo/6S9HIzJOd4TwN08y4R9KX
         e7oAVT87JbvsEXEzGBCKilErNFrhhgfQVBev/xLgCympZaa0V+YLA0i4XqLES2G/0snL
         PIOkuIYruocglohCLtPkNZrdnuDreR/GF7oq/tVHyl76DKOys5mw1sJHchkV0ww40+a5
         KRsg==
X-Forwarded-Encrypted: i=1; AJvYcCX1cXhn2yaBGYn1+mvNSQ4bUGQmn7h7EHS7Zg435hNemJycJNRCq5u01W46mamDage5QjJH+aBaMEl4JXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1zp6gLWEHz1cyQT02BLFKpzK29zGGT+QEgDGv2qi1lEC8P1nI
	SRGeqJlY9C06LPD6zYqVDdMH+kSfFwskUW4UpeO3zjqWfZwni7sXKoY0nEOo
X-Google-Smtp-Source: AGHT+IFRBpRoo9NzkrEOMC5wz2Y+CDpAv1yqEHwHk3FGELvA1ToIzfhxpzwo9RcN9I0LUqwTL2xUZQ==
X-Received: by 2002:a05:600c:4453:b0:426:4978:65f0 with SMTP id 5b1f17b1804b1-42acc8dd846mr37021305e9.18.1724493264101;
        Sat, 24 Aug 2024 02:54:24 -0700 (PDT)
Received: from laptop.. (117.red-83-52-251.dynamicip.rima-tde.net. [83.52.251.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abefc626fsm126301265e9.31.2024.08.24.02.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 02:54:23 -0700 (PDT)
From: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
Subject: [PATCH v3] docs/sp_Sp: Add translation to spanish of the documentation related to EEVDF
Date: Sat, 24 Aug 2024 11:54:02 +0200
Message-Id: <20240824095402.7706-1-sergio.collado@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Translate Documentation/scheduler/sched-eevdf.rst to Spanish.

Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
Reviewed-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
---
 v1 -> v2: corrected the commit message
---
 v2 -> v3: corrected typos
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
index 90a153cad4e8..c146e5bba881 100644
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
+para el gestor de tareas EEVDF, cuya documentación se puede ver en
+Documentation/scheduler/sched-eevdf.rst
 
 El 80% del diseño de CFS puede ser resumido en una única frase: CFS
 básicamente modela una "CPU ideal, precisa y multi-tarea" sobre hardware
diff --git a/Documentation/translations/sp_SP/scheduler/sched-eevdf.rst b/Documentation/translations/sp_SP/scheduler/sched-eevdf.rst
new file mode 100644
index 000000000000..786f7e6637e4
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
+El gestor de tareas EEVDF, del inglés: "Earliest Eligible Virtual Deadline
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
+pueden adelantarse a otras si su VD es más próximo en el tiempo, y las
+tareas podrán pedir porciones de tiempo específicas con la nueva llamada
+del sistema sched_setattr(), todo esto facilitara el trabajo de las aplicaciones
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


