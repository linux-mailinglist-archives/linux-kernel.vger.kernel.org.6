Return-Path: <linux-kernel+bounces-379691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 390019AE255
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FDE2B23C35
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC81B1C4A21;
	Thu, 24 Oct 2024 10:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTFYgM4s"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75541BD028;
	Thu, 24 Oct 2024 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765066; cv=none; b=UE8XJDDrDIAJlqa5xIWR5Hz2HMj3DzgwBjm9GCQ3NJfSdNUJWAmJu4VlknaOjqV+4ZsdFOIDuiFdLAvhQ1dObnoTFdrnSkTqiYaZ6wQlI/hGNFUeHw65Ai7IcJdO5yvh0vCbdz2/foNNl0YXUEO+S+RA0bfIbkwwqoNFKTqI0N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765066; c=relaxed/simple;
	bh=c8Jg98xcpFACVY6GOIH4a4vVaCnNTNjpk0qmHzOUfHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mXCqjgL89Oofm6mNg2I9J3XdZOlFyMumiLdNs428r7UMjS1f5XuUfGsQpKsOInFfChSCrFv6AzzR9nFZEWU2RJy93dwyOqfeTkUm3R2kjClpcCeAwr0QK8yAclV7Thh96oSZNY7sP6l9nNGQQ7sYstN0eZ5dU2i0pChsSXATgag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTFYgM4s; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cf6eea3c0so5334725ad.0;
        Thu, 24 Oct 2024 03:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729765063; x=1730369863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMncn0KiFbXEwxO5HGVMTGntCAI1pNF6ZkKXsjmzxls=;
        b=FTFYgM4sBaYJhVvQ7whjlURP9KNZzg8haue8D63Ga4UifYZzg/FtmLwH6upQSaejw0
         sncESwiVFQtqUwuN52aMZRRlmbGuRLvZMou9FJFrwWgrFCuaDStzChn77FszzlUt1EFE
         W+c+eHRLIJvUqVjnBGEAzaj/9IZImaEW2eBSZi2uOwHyqClSpsX7xKeF4zSJKflTmXRw
         Vpc7F5QtyAtQ+G8ehT16TKAH6g87DyxHC+Mv9yU89aE14WwGoopKwCNOTDgsDLxBnC8M
         fvyZKwNVJ4OTESTJZ0/8ipSGalyYQJDbN7ManRajNP2GP2xnNjVuWFBgKBqDdhA4EpOk
         DFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729765063; x=1730369863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMncn0KiFbXEwxO5HGVMTGntCAI1pNF6ZkKXsjmzxls=;
        b=uEk8ZqT9UTEG3Z1cSamMYs1CnfsKZptqzEDCfBbq6PA4tuIuje4nYbQTIEgCYj3JGK
         83AdVGzICdbexcKVEexXVGipUzPsuQK8Z2xVPbs2sznjOb2AwwPkVZWeO3h7QdTjzLZr
         qCPvMTmtVmqm7eVcDsKIS0sYVIRrLILv3FhR0oHZvO0aPGSbqGjW8zeyv/0yL+Xu3/7R
         lQZrtURkqtxFcPcvHct0AM7lQlQ8psGkRQTh/9GKo5oUwrNChnEhwrttX9ND3lsPG8ZO
         zzaq6ypAdhLlzvE1WeBO8nl8Ay1clCXi52qhw7r9RMq4i8+uSJGZ5JiRIsdHlEP8OQmV
         oZ6A==
X-Forwarded-Encrypted: i=1; AJvYcCVCDGU1jvB82jzYI21i5zHfFkJ3h1/dJILKMKshjUqNjCbOc026wEwJOVEH3VM52Nb9w8aW+ii8Qefv@vger.kernel.org, AJvYcCXPjwd7xt9LzhncN107kBeJmk3YzXq4NHMPQBpm3oICpXw663KgOWna8RIERmNPH6NCxDgO88OdSCQcpZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoJaZKprrkWHqgvb+nkxSrW86jXVNDePsMGFCW8bI8JRfAowWQ
	8e20mJRm5pIkzKPfLaLrTIeyoPKBO8ZFx9E798gdvy641fqBfDtB
X-Google-Smtp-Source: AGHT+IE0ZZptJeQNZ2yXYdqjWFys5LQ0dbKILrWDy93GpnNpyjTIxetByYZKitPhqyz8t3FSH+xpaA==
X-Received: by 2002:a17:902:d2d0:b0:20c:6b11:deef with SMTP id d9443c01a7336-20fb9addb15mr12813925ad.48.1729765062847;
        Thu, 24 Oct 2024 03:17:42 -0700 (PDT)
Received: from asix-MS-7816.. ([2403:c300:5606:d914:fec1:9dc9:d21d:9b02])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd376sm69782065ad.132.2024.10.24.03.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 03:17:42 -0700 (PDT)
From: Tony Chung <tony467913@gmail.com>
To: gregkh@linuxfoundation.org
Cc: johan@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Tony Chung <tony467913@gmail.com>
Subject: [PATCH 3/3] driver: usb: serial: mos7840: add more baudrate options
Date: Thu, 24 Oct 2024 18:09:05 +0800
Message-Id: <20241024100901.69883-4-tony467913@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241024100901.69883-1-tony467913@gmail.com>
References: <20241024100901.69883-1-tony467913@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds more baud rate options using 96M/30M/External clock sources.
To use these clock sources,
set through Clk_Select_Reg1 and Clk_Select_Reg2.

Signed-off-by: Tony Chung <tony467913@gmail.com>
---
 drivers/usb/serial/mos7840.c | 156 ++++++++++++++++++++++++++++++++++-
 1 file changed, 155 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index acc16737b..70ee4a638 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -1169,6 +1169,37 @@ static int mos7840_calc_baud_rate_divisor(struct usb_serial_port *port,
 		*divisor = 0x01;		// DLM=0, DLL=0x01
 		*clk_sel_val = 0x60;	// clock source=24M
 
+	/* below are using 96M or 30M clock source
+	 * will determine the clock source later
+	 * in function mos7840_send_cmd_write_baud_rate
+	 */
+	} else if (baudRate == 6000000) {
+		*divisor = 0x01;		// DLM=0, DLL=0x01
+		*clk_sel_val = 0x80;	// DUMMY val, clock source = 96M
+	} else if (baudRate == 2000000) {
+		*divisor = 0x03;		// DLM=0, DLL=0x03
+		*clk_sel_val = 0x80;	// DUMMY val, clock source = 96M
+	} else if (baudRate == 403200) {
+		*divisor = 0x0f;		// DLM=0, DLL=0x0f
+		*clk_sel_val = 0x80;	// DUMMY val, clock source = 96M
+	} else if (baudRate == 225000) {
+		*divisor = 0x1b;		// DLM=0, DLL=0x1b
+		*clk_sel_val = 0x80;	// DUMMY val, clock source = 96M
+	} else if (baudRate == 153600) {
+		*divisor = 0x27;		// DLM=0, DLL=0x27
+		*clk_sel_val = 0x80;	// DUMMY val, clock source = 96M
+
+	} else if (baudRate == 10000) {
+		*divisor = 0xbb;		// DLM=0, DLL=0xbb
+		*clk_sel_val = 0x80;	// DUMMY val, clock source = 30M
+	} else if (baudRate == 125000) {
+		*divisor = 0x0f;		// DLM=0, DLL=0x0f
+		*clk_sel_val = 0x80;	// DUMMY val, clock source = 30M
+	} else if (baudRate == 625000) {
+		*divisor = 0x03;		// DLM=0, DLL=0x03
+		*clk_sel_val = 0x80;	// DUMMY val, clock source = 30M
+
+
 	} else if (baudRate <= 115200) {
 		*divisor = 115200 / baudRate;
 		*clk_sel_val = 0x0;
@@ -1246,11 +1277,134 @@ static int mos7840_send_cmd_write_baud_rate(struct moschip_port *mos7840_port,
 
 	}
 
-	if (1) {		/* baudRate <= 115200) */
+	if (1) {
 		clk_sel_val = 0x0;
 		Data = 0x0;
 		status = mos7840_calc_baud_rate_divisor(port, baudRate, &divisor,
 						   &clk_sel_val);
+		if (status < 0) {
+			dev_dbg(&port->dev, "%s failed in set_serial_baud\n", __func__);
+			return -1;
+		}
+
+		/* Write clk_sel_val to SP_Reg or Clk_Select_Reg*/
+		// check clk_sel_val before setting the clk_sel_val
+		if (clk_sel_val == 0x80) {
+		// clk_sel_val is DUMMY value -> Write the corresponding value to Clk_Select_Reg
+			// 0x01:30M, 0x02:96M, 0x05:External Clock
+			if (baudRate == 125000 || baudRate == 625000 || baudRate == 10000) {
+				clk_sel_val = 0x01;
+			} else if (baudRate == 153600 || baudRate == 225000 || baudRate == 403200 ||
+					baudRate == 2000000 || baudRate == 6000000) {
+				clk_sel_val = 0x02;
+			} else {
+				clk_sel_val = 0x05; // externel clk for custom case.
+			}
+
+			// needs to set clock source through
+			// Clk_Select_Reg1(offset 0x13) & Clk_Select_Reg2(offset 0x14)
+			// Clk_Select_Reg1 for port1,2		Clk_Select_Reg2 for port3,4
+			if (mos7840_port->port_num <= 2) {
+				status = mos7840_get_reg_sync(port, CLOCK_SELECT_REG1, &Data);
+				if (status < 0) {
+					dev_dbg(&port->dev, "reading Clk_Select_Reg failed in set_serial_baud\n");
+					return -1;
+				}
+				if (mos7840_port->port_num == 1) {
+					Data = (Data & 0xf8) | clk_sel_val;
+					status =
+						mos7840_set_reg_sync(port, CLOCK_SELECT_REG1, Data);
+				} else if (mos7840_port->port_num == 2) {
+					Data = (Data & 0xc7) | (clk_sel_val<<3);
+					status =
+						mos7840_set_reg_sync(port, CLOCK_SELECT_REG1, Data);
+				}
+				if (status < 0) {
+					dev_dbg(&port->dev, "setting Clk_Select_Reg failed\n");
+					return -1;
+				}
+			} else if (mos7840_port->port_num <= 4) {
+				status = mos7840_get_reg_sync(port, CLOCK_SELECT_REG2, &Data);
+				if (status < 0) {
+					dev_dbg(&port->dev, "reading Clk_Select_Reg failed in set_serial_baud\n");
+					return -1;
+				}
+				if (mos7840_port->port_num == 3) {
+					Data = (Data & 0xf8) | clk_sel_val;
+					status =
+						mos7840_set_reg_sync(port, CLOCK_SELECT_REG2, Data);
+				} else if (mos7840_port->port_num == 4) {
+					Data = (Data & 0xc7) | (clk_sel_val<<3);
+					status =
+						mos7840_set_reg_sync(port, CLOCK_SELECT_REG2, Data);
+				}
+				if (status < 0) {
+					dev_dbg(&port->dev, "setting Clk_Select_Reg failed\n");
+					return -1;
+				}
+			}
+		} else {
+		// clk_sel_val is not DUMMY value -> Write the corresponding value to SP_Reg
+
+			/* First, needs to write default value to
+			 * Clk_Select_Reg1(offset 0x13) & Clk_Select_Reg2(offset 0x14)
+			 * Clk_Select_Reg1 for port1,2		Clk_Select_Reg2 for port3,4
+			 */
+			if (mos7840_port->port_num <= 2) {
+				status = mos7840_get_reg_sync(port, CLOCK_SELECT_REG1, &Data);
+				if (status < 0) {
+					dev_dbg(&port->dev, "reading Clk_Select_Reg failed in set_serial_baud\n");
+					return -1;
+				}
+				if (mos7840_port->port_num == 1) {
+					Data = (Data & 0xf8) | 0x00;
+					status =
+						mos7840_set_reg_sync(port, CLOCK_SELECT_REG1, Data);
+				} else if (mos7840_port->port_num == 2) {
+					Data = (Data & 0xc7) | (0x00<<3);
+					status =
+						mos7840_set_reg_sync(port, CLOCK_SELECT_REG1, Data);
+				}
+				if (status < 0) {
+					dev_dbg(&port->dev, "setting Clk_Select_Reg failed\n");
+					return -1;
+				}
+			} else if (mos7840_port->port_num <= 4) {
+				status = mos7840_get_reg_sync(port, CLOCK_SELECT_REG2, &Data);
+				if (status < 0) {
+					dev_dbg(&port->dev, "reading Clk_Select_Reg failed in set_serial_baud\n");
+					return -1;
+				}
+				if (mos7840_port->port_num == 3) {
+					Data = (Data & 0xf8) | 0x00;
+					status =
+						mos7840_set_reg_sync(port, CLOCK_SELECT_REG2, Data);
+				} else if (mos7840_port->port_num == 4) {
+					Data = (Data & 0xc7) | (0x00<<3);
+					status =
+						mos7840_set_reg_sync(port, CLOCK_SELECT_REG2, Data);
+				}
+				if (status < 0) {
+					dev_dbg(&port->dev, "setting Clk_Select_Reg failed\n");
+					return -1;
+				}
+			}
+			// select clock source by writing clk_sel_val to SPx_Reg
+			status = mos7840_get_reg_sync(port, mos7840_port->SpRegOffset,
+									 &Data);
+			if (status < 0) {
+				dev_dbg(&port->dev, "reading spreg failed in set_serial_baud\n");
+				return -1;
+			}
+			Data = (Data & 0x8f) | clk_sel_val;
+			status = mos7840_set_reg_sync(port, mos7840_port->SpRegOffset,
+									Data);
+			if (status < 0) {
+				dev_dbg(&port->dev, "Writing spreg failed in set_serial_baud\n");
+				return -1;
+			}
+		}
+
 		status = mos7840_get_reg_sync(port, mos7840_port->SpRegOffset,
 								 &Data);
 		if (status < 0) {
-- 
2.34.1


