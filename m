Return-Path: <linux-kernel+bounces-425744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F01C9DEA13
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66850163B62
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 15:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3051A01B3;
	Fri, 29 Nov 2024 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKQ3OUY7"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8748D19DF47;
	Fri, 29 Nov 2024 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732895946; cv=none; b=epoIDS73Gp+M9t+ezskE0xlDcb9Kxo21X2tdn6WtkuZOwI7byUbRf0SpWzrrS37tgcLU3Ra0IplY4KVTZIpfbGqAiR5R6rTeQxxyGsBO9q3hht/kHRAvjMDB7estDeBNFVGM9oKqB87sY0WyGXO+vrrIDywjqBGKhKMpjlYbnh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732895946; c=relaxed/simple;
	bh=VDeprDTicXna6kpAAeukLMt08eeVdWnJ9nmGXd+UXqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k57tprksbrc/IgKPdBCagkmNVZv8Kd+Nr1tvItX6E6zrEDiSrJtoq+pn55g720Q8epw8gFc8mQP3amY0vzQtgZv75+JNh56AlIiGpZXBKPPRTjhknHGXMMSPff5ShhTfEo0AGRo5mZ1F3OlUCO8iUy8VF3H+PbwhmmLIpDIZHew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKQ3OUY7; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71d551855c2so810228a34.3;
        Fri, 29 Nov 2024 07:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732895944; x=1733500744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6qEX0ra3qWfSu3iSNGny6l2UFPA6gOod5SJz2RGJZg=;
        b=PKQ3OUY7LX8aJvuW/Vmwl1P0zrLcazwXOxJnpcLVsGhoDbvGlo3jB+XCf+ZMefxTWB
         NxTxN0NTid2FKUmEJUPawHgB7dh5SjzBDJuxDX7/A96HqERCjqQZ6SPmtPCWjYmLcRIZ
         Uu6TNwDd1m44cLhJtVQNnvE2JR8utXrkc/3+Z+ptGOy9Pt/hWIPlEIOUdCE+BvtMCPWg
         6lNus4tnYV8WWwC/UKVDyp3gaGPV7e8534YeJ+D/wVAfgHNby2WHPyDzLsMxWjCX7Dic
         Maiem1Bo2XUfx88X7UdmPM9RvNJaEtN3u8TP0YcV28H0XODpPnuSXl2N8WMg3y6sgbHs
         F23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732895944; x=1733500744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6qEX0ra3qWfSu3iSNGny6l2UFPA6gOod5SJz2RGJZg=;
        b=Krfm1NKbr9S4y9ubzJ1gsyVxo4wJWiXZidJ9Vk5rkQQ3ibS6JvWj8Q7mHPDyuec5N/
         7ctjYh0nYbRnj7m7I/SyPIw5SmezrQ2lZ0e0E+5FI5FCTiJQDdL0MhCtReRsAHyoDE/v
         sx7ibZp5Q2iKYckc7AVdVbp1ohFeAllUm3xpWZ0cvltw80BWmb/bXWh0tiav80ptLmw+
         +adrJaMtOxlSkiWeUXpLOpV3pJBSH1/HSEJyqAr8qmRE0JWU/C6ttxWdcqzP/t4tS/lD
         XjaCXruXtG9YtXG00/b7aCC/1TF/i2nJyEWabBEJNf1w4CidKZqr0U5lv5BgR3QDX7ic
         QlVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtT2fs5eid+sBtH079Ehtz37i6r4z5Ai1xGwp0tfSWyc+f9PBYMkYbXhP9rBiGcdv1yHIZKfqT0hyC+fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM7SPLoZYjN6iVLEiMmtoiazJkuIuTHVGnO55sZgsp2j9b2+Va
	Q38KcYiDEXfsEmf4TFbjPv/iWPj6ZDkFJVbZbOVBHzRBGMH8+Ndv
X-Gm-Gg: ASbGncvOU7JzKHHneEO9mqh0SPrwR2acTbw9BmDSWswwGEdVX1EBwyVPWKu01xI+uj+
	0W0sKTQ6dHSZFlsz2n2VWuw+/F8Q2gtvTg1JXBPsDySqaOqCvRf3EapHF85qVQHTNpjBAXOzco1
	Jth/7iy4W4uyDgPcIFxX+MbLFH7nJRvUvlQQx0d1MaXzdDO34V+MUfmyQvS7jVyWA+Cd+ggZraQ
	9QCJHAAA/wPmkn2S70qPPWE+xtQHhaeWJ2XVcawji+MdsLrG5klXSp8d6CivaWNXWwfTXxIp/lL
X-Google-Smtp-Source: AGHT+IG6Z6fRSs4Zug2I8mFKNdNbMayY7kfoGAxg65YRVvZTj/fgG/KU+vyaVfTX1+Qb0bhuz4BT9Q==
X-Received: by 2002:a05:6830:4112:b0:71d:4e0f:bf58 with SMTP id 46e09a7af769-71d65e8c78fmr10113431a34.30.1732895943632;
        Fri, 29 Nov 2024 07:59:03 -0800 (PST)
Received: from pipaware.tx.rr.com ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71d725f2251sm794385a34.68.2024.11.29.07.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 07:59:03 -0800 (PST)
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
To: corbet@lwn.net,
	avadhut.naik@amd.com,
	bilbao@vt.edu
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Subject: [PATCH 6/7] docs/sp_SP: Add translation of process/8.Conclusion.rst
Date: Fri, 29 Nov 2024 09:58:46 -0600
Message-ID: <20241129155851.1023884-7-carlos.bilbao.osdev@gmail.com>
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

Translate Documentation/process/8.Conclusion.rst into Spanish, finishing
the development-process docs.

Co-developed-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
---
 .../sp_SP/process/8.Conclusion.rst            | 75 ++++++++++++++++++-
 .../sp_SP/process/development-process.rst     |  1 +
 2 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/sp_SP/process/8.Conclusion.rst b/Documentation/translations/sp_SP/process/8.Conclusion.rst
index dd181cb8ec9a..d311a23d53df 100644
--- a/Documentation/translations/sp_SP/process/8.Conclusion.rst
+++ b/Documentation/translations/sp_SP/process/8.Conclusion.rst
@@ -1,11 +1,82 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: Documentation/process/8.Conclusion.rst
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com> and Avadhut Naik <avadhut.naik@amd.com>
 
 .. _sp_development_conclusion:
 
 Para más información
 ====================
 
-.. warning::
-	TODO aún no traducido
+Hay numerosas fuentes de información sobre el desarrollo del kernel de
+Linux y temas relacionados. La primera de ellas será el directorio de
+Documentación (Documentation) que se encuentra en la distribución del
+código fuente del kernel. Comience con el nivel superior
+:ref:`Documentation/translations/sp_SP/process/howto.rst <sp_process_howto>`;
+también lea
+:ref:`Documentation/translations/sp_SP/process/submitting-patches.rst <sp_submittingpatches>`.
+Muchas API internas del kernel están documentadas utilizando el mecanismo
+de kerneldoc; “make htmldocs” o “make pdfdocs” se pueden usar para
+generar esos documentos en formato HTML o PDF (aunque la versión de TeX
+incluida en algunas distribuciones tiene límites internos y no procesa
+los documentos correctamente).
+
+Varios sitios web discuten el desarrollo del kernel en todos los niveles
+de detalle. A su autor le gustaría sugerir humildemente https://lwn.net/
+como fuente. La información sobre muchos temas específicos del kernel se
+puede encontrar a través del índice del kernel de LWN en:
+
+	https://lwn.net/Kernel/Index/
+
+Más allá de eso, un recurso valioso para los desarrolladores del kernel
+es:
+
+	https://kernelnewbies.org/
+
+Y, por supuesto, no se debe olvidar https://kernel.org/, la ubicación
+definitiva para información de lanzamiento del kernel.
+
+Hay varios libros sobre el desarrollo del kernel:
+
+	Linux Device Drivers, 3rd Edition (Jonathan Corbet, Alessandro
+	Rubini, and Greg Kroah-Hartman).  En linea en
+	https://lwn.net/Kernel/LDD3/.
+
+	Linux Kernel Development (Robert Love).
+
+	Understanding the Linux Kernel (Daniel Bovet and Marco Cesati).
+
+Todos estos libros padecen un defecto común: suelen estar algo obsoletos
+cuando llegan a las estanterías, y ya llevan un tiempo en las estanterías.
+Aun así, hay bastante buena información que se puede encontrar allí.
+
+La documentación de git se puede encontrar en:
+
+	https://www.kernel.org/pub/software/scm/git/docs/
+
+	https://www.kernel.org/pub/software/scm/git/docs/user-manual.html
+
+Conclusión
+==========
+
+Felicitaciones a todos los que han logrado leer este extenso documento.
+Con suerte, ha proporcionado una comprensión útil de cómo se desarrolla
+el kernel Linux y cómo puede participar en ese proceso.
+
+Al final, lo que importa es la participación. Cualquier proyecto de
+software de código abierto no es más que la suma de lo que sus
+colaboradores aportan. El kernel Linux ha progresado tan rápido y tan como
+lo ha hecho porque ha sido ayudado por un grupo impresionantemente grande
+de desarrolladores, todos los cuales están trabajando para mejorarlo. El
+kernel es un excelente ejemplo de lo que se puede lograr cuando miles de
+personas trabajan juntas hacia un objetivo común.
+
+Sin embargo, el kernel siempre puede beneficiarse de una base de
+desarrolladores más grande. Siempre hay más trabajo por hacer. Pero, lo
+que es igual de importante, la mayoría de los demás participantes en el
+ecosistema Linux pueden beneficiarse contribuyendo al kernel. Introducir
+código en el mainline es la clave para una mayor calidad del código,
+menores costes de mantenimiento y distribución, un mayor nivel de
+influencia sobre la dirección del desarrollo del kernel y más. Es una
+situación en la que todos los involucrados ganan. Encienda su editor y
+únase a nosotros; será más que bienvenido.
diff --git a/Documentation/translations/sp_SP/process/development-process.rst b/Documentation/translations/sp_SP/process/development-process.rst
index ecfa04d96b5e..5430c4cc001b 100644
--- a/Documentation/translations/sp_SP/process/development-process.rst
+++ b/Documentation/translations/sp_SP/process/development-process.rst
@@ -30,3 +30,4 @@ para entenderla.
    5.Posting
    6.Followthrough
    7.AdvancedTopics
+   8.Conclusion
-- 
2.43.0


