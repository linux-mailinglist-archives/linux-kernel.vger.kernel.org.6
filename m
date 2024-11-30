Return-Path: <linux-kernel+bounces-426226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFD89DF089
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 14:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8DF281402
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 13:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F62A199FDC;
	Sat, 30 Nov 2024 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqazGOQE"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E218145B10;
	Sat, 30 Nov 2024 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732973927; cv=none; b=bc6daKLBCmMSnn+tLGr3begRw6rRSix1aR80r3EfHwKbBGH45Im/C/6ltz7Z0iUQS5ji9CNhxbhuwJ+Eb4ybJ8T16yoJOo4ZD9L27HCOPB7HLDEvkjmrYJjvhv0PYwo1FFHHZ7SA9dhajt/ypVM8Wp5w3o3AMaZJAx4VCGYoUkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732973927; c=relaxed/simple;
	bh=0MrmF4gw/0awDZqXHE+Emfo+/VFHgrjx3hIifpJOJOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WIKXtM9jkIoNEzG1NJuh9dYN/NtyFk4NkPPWtD3R34Q8/9Ig6iahrDCAHxrmCaUhKoxXydWWA45f2luc2IcAkdSn6UD36NuaG7MSqhiQYHMUN1AtyEht4B0ILx6qCEChDCayacONRAujEUh4Gzm6zMz01Q5Q0h9T029k4jsPZCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqazGOQE; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7251ce598adso1827884b3a.0;
        Sat, 30 Nov 2024 05:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732973926; x=1733578726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uIuvmjg2DchrQhWGRqPS3D1V7tXpFMSCktn0tzsLkY0=;
        b=nqazGOQEy+g22giEv3B5uTto9TZO98OEhFnjAJImMu57+0lY9ECLqa6LsIrwz6/uJg
         n9jU98tD4ufO6WPZU9fV6gcRuBNcfF5Evp1thOYlQ+Zw/BndCmhs1paf4j13mqbv38ZY
         AKVdVkyYBwtfHyoD/srW6MS+e0aR1sOKlSASwoQIWWdyeSW0csADUSpZjKsaFn9e3reS
         zCHeKzXDARhX3OQhwB7hWBPZUCIMFCJrA3CjffTz8mxngMAI1gO1s7IaPeQYPCgv3Vi7
         E6wKZYsuLiRdj8XDh2OcTGGOBsrRv7rcrcuUItDVSMvf8LPoKQi4XZWnlYNlMTV0ojb1
         kI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732973926; x=1733578726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uIuvmjg2DchrQhWGRqPS3D1V7tXpFMSCktn0tzsLkY0=;
        b=MNNpJZbgiU+fgq1HAQmwSkEBcck7qmM1ja7CD7rGswDRnCzj84xO96MCPT7ZInB7W4
         SPGfEMaqKnb8Kk3ydIA4ovma8bJfyuI4+GmQfGsUyMm2KKNHS/pN1iC57SREpiddbh6Z
         Z5El68Ko7SNJqs1fjbPQBaei7p6ZolL2ZNjRIiWln4MiRH3fAOu6wbTvgTat1kO4pgIL
         FKbzKYgxKn+pAtIWsaApI53hsJVLBIDMzya0Yq4KBKgl3fO9IhzqNgipD63C+8FPhcqc
         IXYkM35bu9I/5/2D1rRdAmlvsCLOCvtYwFFfz4FsbsNboD2hkwMuM9lIndOzz3n97qqS
         8gsA==
X-Forwarded-Encrypted: i=1; AJvYcCU6agxQJoSivTKBAYHnCm/tL1n8b49eIO49mEhz9AuhJ/20BNxJu43mgZs/LjC136/y0jGoxZeQjXE=@vger.kernel.org, AJvYcCUCi3ng/QbEnJmpfHFR+g+JUZHxmMGkbaU8quT8lOi7iIFsf5qTLeZhNeZ0g8jfitfwRYB/CuVz9L8oIVE=@vger.kernel.org, AJvYcCWIVXPTW/vPVRzblnsc1eqcn0S+0JlxImezubZi1gK9FxQPmE/Xfnl6LT5oCLwyvVpJhSCmYBcgsPBGuaU2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/61XZFOH39yzusHWvjbrDSyBGV6vQyg42jkWo4stonGABzMWO
	0Ps2p87a0OF7Jo0wgeOD4f0DksrvK7oPjQOC0vfoJVilm3kPwxrufs+rEZTx
X-Gm-Gg: ASbGncuzgOzaNk3XbUKrJKUWzjqlQ1zClR/WWWOoNopusB4AdTXEQ2nPIGo3FY/81pn
	JGk9zhe02gsmH4OJtzpDpISUAo81EqmyU11TuG4TEawI+fgVhTV8lEnqIak5kvW5cYcX0tn04pA
	+yJRIDkDteFBUtqJTMnleaEY/W/xa+Axe2x8EXUW0Ol+ozhCPu7lZSAp/m13bV2X6P1+0VkzJNI
	khvN+oZC+bFLDt/cd43RG5PQk/XAmE2ktk0FX3Ys3qROnxiOqYrAYM9izbqhiq8
X-Google-Smtp-Source: AGHT+IFAX0Ra5YDnqqmM97d9Pdhb7Vfmb+vJyc2BZqtGJDr3mwkLXFdU2F9VeJjVJarSIWKXfuXbTw==
X-Received: by 2002:a17:902:ea0e:b0:20b:4f95:932d with SMTP id d9443c01a7336-2150108ca34mr208283235ad.3.1732973925856;
        Sat, 30 Nov 2024 05:38:45 -0800 (PST)
Received: from localhost.localdomain ([38.47.127.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2156b1601basm5954215ad.196.2024.11.30.05.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 05:38:45 -0800 (PST)
From: Li XingYang <yanhuoguifan@gmail.com>
To: eugene.shalygin@gmail.com
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	corbet@lwn.net,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li XingYang <yanhuoguifan@gmail.com>
Subject: [PATCH 0/1] hwmon: (asus-ec-sensors) add TUF GAMING X670E PLUS
Date: Sat, 30 Nov 2024 21:38:33 +0800
Message-ID: <20241130133837.24454-1-yanhuoguifan@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


this is my mainboard:
dmidecode | grep -A3 "Base Board"
Base Board Information
        Manufacturer: ASUSTeK COMPUTER INC.
        Product Name: TUF GAMING X670E-PLUS
        Version: Rev 1.xx

i use the version of BIOS:
TUF-GAMING-X670E-PLUS-ASUS-3042

asus-ec-sensors show when use this patch:
sensors 'asusec-*'
asusec-isa-0000
Adapter: ISA adapter
CPU_Opt:      914 RPM
CPU:          +39.0°C
CPU Package:  +48.0°C
Motherboard:  +31.0°C
VRM:          +46.0°C
Water_In:     +35.0°C
Water_Out:    +33.0°C


Li XingYang (1):
  hwmon: (asus-ec-sensors) add TUF GAMING X670E PLUS

 Documentation/hwmon/asus_ec_sensors.rst |  1 +
 drivers/hwmon/asus-ec-sensors.c         | 13 +++++++++++++
 2 files changed, 14 insertions(+)

-- 
2.47.1


