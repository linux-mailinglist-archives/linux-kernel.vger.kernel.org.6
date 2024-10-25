Return-Path: <linux-kernel+bounces-381435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45A39AFF32
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66B01C21CA8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A3E1D4153;
	Fri, 25 Oct 2024 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJj3meB5"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2561D4359;
	Fri, 25 Oct 2024 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850360; cv=none; b=S3n/74kBgcIW7db8kWEuLuUgt0HDAQn0z/0ZGkijRcTANAEPKlcjhzy//Mefhnm7osBR7Vs8D/b5cABjA/7QMOy50IWhEQ4XnFshDxVflhd8Nz/zkdI8zQ5QREaBVot90qGg7F482pjLkxwsBZzkrdFw2/6qDqXuiwmDFAOhFf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850360; c=relaxed/simple;
	bh=N1CyolZ8tBLpfASJJeTZ0XeLoaebRErSyJBGK6pKilA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ILO0qaAMUS4OCrBGMM0LwqjWRDmwjme0M2+DuLUOE3mng2zWbxxJMQUfDMHzzBCKDQQO2wf+UBh3M/jIbSkufUB23VxeRCWNDIgvqcJSNUSKwC4JKtkiN+4c6tMKxyQnapv79vCWFEU/aTRexANeu8Nv4TUDdcI/JUsNAVjlmfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJj3meB5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43155afca99so19883035e9.1;
        Fri, 25 Oct 2024 02:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729850357; x=1730455157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E4cr4e2WpYdldiza6Smv9BM5tV2IoSAN/lMOvuaNoy8=;
        b=TJj3meB5j8B0YvVxdP5mOmLLC88I42KHPjM8jnV+vgsL1ykXM4PLRHdyouKeAHtH36
         IqK0lRmGuPbPPERk7B3Sg2FzM/Yjp5IRQMG6LFwZpAUVRrcLqB4EQVUD97srm7l+1KQU
         w27ltf236ZS2GBellxBkmKnmey9lETt6xFGhLszcUtHRLPhbBqNUEFn7mBlSqahQl7Pj
         V5dcufthzCfuIJ68LcZKQfGHRdGDdCP5cAjB3AZ3gOw4tNZbScTTsIYKMJe1meeZ6hE+
         +yLeUSo4FfWl5SpBX+161I6Yt0QC01OrVC8EmB8Wj5G/DhqNhto2MdFyJk57TNZCYfgb
         2r3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729850357; x=1730455157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E4cr4e2WpYdldiza6Smv9BM5tV2IoSAN/lMOvuaNoy8=;
        b=tvb0JFh09ZyfKBDuwoyR7XQZgqPAdEj0EvUWcYQ2yLlKre5TzQzoXIkGaMSH1y4O5R
         uLhty4DZp0YmGRp40y2In3FdmiDbRj78LhMJ74vAURZlABu83tbQ6Z/in2PDqU4MJ+hK
         PH+5oOC41wRwzgiDMbjlCuTcirbLCHFRMv3yJ3PeaLL/mgdhPZVc3hSpHzYuSYkMRE2k
         wGTF0PSRqvgu/MqIkPMooVjC5mXUPoferQzMSjg5uyYN9acaQQfGLjCMljDTYGXElrL9
         K8JCVsf4EHrTgb0PCvctrRpI3knGOVncSUYlJdMy/JknpSWtUC9697hErnY26jHZ7HF+
         ZeMw==
X-Forwarded-Encrypted: i=1; AJvYcCXf0s3V7TllBg1TVq1UpRyoBoOmBa8QmZNJz2ikdoKcveHGjQAbC/JKEPzrpa06kqE06WiNNvu8B1NCu10=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyHmlQJ+5rmLVluKnIbIEUccEFMMPgLCIVbPg2pOXLIU5kAGxX
	lmk5mVZDH7dTjD1R/FlreCcltl8qUpT78vBPqDi0/psnZF+DB3FQ
X-Google-Smtp-Source: AGHT+IGsDr1xiNpVz0zWvEjm8K23MeXnqNJoj9pKxKeUpb6r2cNqS3tSAm+MEb1ei9011b3zn/BiAg==
X-Received: by 2002:a05:600c:1c81:b0:42c:b67b:816b with SMTP id 5b1f17b1804b1-4318b587a84mr36861205e9.1.1729850356816;
        Fri, 25 Oct 2024 02:59:16 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72:0:7bc0:826e:69e3:7e40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3c7b9sm1098214f8f.32.2024.10.25.02.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:59:16 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	francesco.dolcini@toradex.com
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] arm64: dts: imx8mm/imx8mp-verdin: add single-master property to all i2c nodes
Date: Fri, 25 Oct 2024 11:58:01 +0200
Message-ID: <20241025095915.22313-1-eichest@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the single-master property to all i2c nodes on the iMX8MM and iMX8MP
Verdin modules. This will allow us to use some single-master
optimisations on the i2c driver. Together with the following series, now
in the i2c-host branch of Andis tree, we get rid of a timeout problem on
the i2c bus with a SMBus ADC:
https://lore.kernel.org/all/7ts577rxed4mmfkfin7kfdjfjkb6iak2y4vtgtz6merwxkzz6w@h5aefbvyx44u/

Stefan Eichenberger (2):
  arm64: dts: imx8mm-verdin: add single-master property to all i2c nodes
  arm64: dts: imx8mp-verdin: add single-master property to all i2c nodes

 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 4 ++++
 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 5 +++++
 2 files changed, 9 insertions(+)

-- 
2.43.0


