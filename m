Return-Path: <linux-kernel+bounces-516768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE18BA37724
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 20:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37EB63AE172
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 19:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C48D1A255C;
	Sun, 16 Feb 2025 19:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="a8YbtLqL"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A56743166;
	Sun, 16 Feb 2025 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739734399; cv=none; b=iGmPt95QRGuWEWS8jdrKdSPaG4fpXRdAoBdPuapc+4NFzCiN2TXOAjuHl2/NkYAqThRSb0xTMhH9z6Y7mFo9dmAUmt+sC5FV8n8Ii8akVSoXMGQ5gwr6KFve4IPPh5chcW9QYmQTa0WO9FS4/OajJ9NbAs/+kxj1MpdKPp6ZHVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739734399; c=relaxed/simple;
	bh=bY9wGJAHHKJfi5+faI192PpB74uBuDOL4lP2cm/vKCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UiBTIuXDtmSkCs7XrvMvtmlOVFZfsBrVrN9aZBsW6x7tdDMuJgozexbF8GfQPMoon8NWwDyL+At40EbM/8vGHLcEsYWiG1jbqeBUmmkrbQG8Mma2VknRXXk3wmkJLVrLVHl8lXhtaxd7d6ByYz4oOPvZanjswXgrqWP7pXYL5M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=a8YbtLqL; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739734379; x=1740339179; i=w_armin@gmx.de;
	bh=mM2EQkLQYCZVlwJp2GMGxpCWqqXp/hAG0cIERHbUn/s=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=a8YbtLqL6i+1C5PcwHa5GebcEwOULxrl71rlDnpYp2K8rpy7RfQcVHXq0AAkRDp9
	 EYrQ65Jod6PZcRefo3xOYPbKzR5gshPnOHum/fDxhBpqwp8wHvsfNjoAnBtfA7CEL
	 iSxYPtNmSz15iILXvH0JSSSN56pxWMMrHHcufE6iIVytFeVe4s4+NqU72kxpSJ51Y
	 PIzXC7r4jcSlASwr74JjMfKiQb8vAAdQeLITy3zFKFNcFERSbiTB9MoT60xVHjOHG
	 nAykRyGuQp1Pc0LjjBTHFigy6PW5ydNckADCsh8tZFyD3KNe/b83Q0wy8GTI1Qzkz
	 qtOjSd7ki4gj4CChPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MOzOw-1u0Hhf0WSK-00K8gK; Sun, 16 Feb 2025 20:32:59 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: james@equiv.tech,
	markpearson@lenovo.com,
	jorge.lopez2@hp.com
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 1/8] hwmon: (hp-wmi-sensors) Use the WMI bus API when accessing sensors
Date: Sun, 16 Feb 2025 20:32:44 +0100
Message-Id: <20250216193251.866125-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250216193251.866125-1-W_Armin@gmx.de>
References: <20250216193251.866125-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kci9+d/nK9nZ7kslj4gKHXclO1R0iKB9O3BgiKYatv7zbOAcECO
 3wD8C7DPfxcLEakjPkpn3hox+k5YvWkHjMNvZoZ/WuArD3pT1oJxXkwbkiD5OwZNiUr05lj
 I0Bqj/AQu7e+CgymGFTY+tUE6Gxbj8cCXJi5H2AFlii16BrE05WsoaB2loclpl1SVcCm9I1
 3d14vciUE0uHhqq3Wx9ew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SkSnWk2fMaA=;qcUOHmLyfPHbpjMeIxxnMoYqZHE
 5J7vw2risTVkmrzfqMa3gV/gEMNxFUMsnBoCijrF9Humm81gOgSo+X8/le0efE0tvfaTOa0FT
 LUzsZKUt88PbmT4ZRbCqv0dilheo15adhuKF6bcliKnWqeLPPza5GOAinvy+N1P1nDY4v8aQj
 VlctrsOG0U9xsfrmVyiRlELNJJATJuZxzq2LfcBCD1MLCWxgxGpPnxENFwtyvSYgqCGmhuarI
 f8jTH/wkW1qkmsl4Wb3ZkirXxf3FIl0JepEYzGle5H3ksfQVVJXxzyc/cDwAAnDDrbatjUbxC
 e1B6MuBTgtwdFd3quVkwwoOiLycOWXHQsK9ljUkGru8csz0E7Ow0ridGGAoOFCjtcm4WQelvc
 5kUgGXs1UN2ECqJNLiHQZ75VNy0pfq2Gj3exfpp2XguePzgKoulYiRWuJrdUpGRRDnmdbO/yZ
 VaZzJL9WLp69uk8RtRlhHTta2E4K32No6r01JmH2dZepzrbkXIbp6Lfwd41dg83nVV9jUuEaW
 a+qgkVdkjOw7rCxFCdC4hAboDOnSXdAAcEsmTGaMW/SfJ7DwsKgHhlqu1ngaXk7C+QL3XY0TP
 epz1xSwWbqJPJ16JLao+Hdx5MMq6ftbg7Um+o4tT7XsxGus/GOb15nGtdaramvI2xnDODAk9e
 3OKKp/o2GTIXRRKvFE4SqXGCk9pwKVWeFBZ7RD9g+9HJWoTnx1rz71DziHDz3+6p01Hz1kIQU
 CeESjbNC7CFajAW7cmvv2d9eBD14IG40pI0iQRrXnxE6vRxC7JRfI4+xLiug3VMYK5k8SJUKK
 nlnYePoO6Rh0vEo9bKL7mNSDunqVBUacdDOTWHPm8K6lQBFaWAHct6RS0hdEpPKAqsKDuWuA4
 yiMuhqlDLVZNX1Rd8c8Gy2tSfIabJv6t9Ya756dgPmwHXWVOELRgqp9L1hi05LITvBNvJ9A04
 v2+IxoIcl7ZEjttwbxHcIo89DGey7U2DzEAxusA0rGrhbpy/HXDqsZbN8JxJ9cWIxh+Qi6Ljs
 Z8bgSnHo3Mwa3FkoAmJjzSnGzA+kaDFf4A+yEkHA9z5DGb7GcPK3GKFiWNkOpqesYvYacC0oC
 +pbofvYA5HxvmZb5CmIN9XZV8HdcqZiIUhk//iLJutGgiGFMcNVSALzfYcpfM3YlhpbmJ9LTn
 YNDUi6QockjyRfflIjowKsjxFqRPQcjnzdcuHyN5y8mQ+dZEbLFvCR5oVSNaTPdz0rcierJr9
 8coOUGd0nmhucCfrxNo3/PBDVIQNQ0eJs5mHHVuYvEpqrgRtC1VDInVOge6cv6Y3IzMzfPjc6
 znAr8QlOVwM5q+r+AzZO0m/P74j4fX8nH78X+8+OEPq7cgpj1KuMAwNXx+dro9x2slpkyxYSn
 I8cLwFtrvJzydrrl9Fx8dLcbDtno18klRen5V38EC/lCcSZFdbAfWDOtZd

Since the driver already binds to HP_WMI_NUMERIC_SENSOR_GUID, using
wmidev_block_query() allows for faster sensor access.

Acked-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: James Seo <james@equiv.tech>
Reviewed-by: James Seo <james@equiv.tech>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/hp-wmi-sensors.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/hp-wmi-sensors.c b/drivers/hwmon/hp-wmi-sensors=
.c
index d6bdad26feb1..03c684ba83bd 100644
=2D-- a/drivers/hwmon/hp-wmi-sensors.c
+++ b/drivers/hwmon/hp-wmi-sensors.c
@@ -1197,7 +1197,7 @@ static int hp_wmi_update_info(struct hp_wmi_sensors =
*state,
 	if (time_after(jiffies, info->last_updated + HZ)) {
 		mutex_lock(&state->lock);

-		wobj =3D hp_wmi_get_wobj(HP_WMI_NUMERIC_SENSOR_GUID, instance);
+		wobj =3D wmidev_block_query(state->wdev, instance);
 		if (!wobj) {
 			ret =3D -EIO;
 			goto out_unlock;
@@ -1745,7 +1745,7 @@ static int init_numeric_sensors(struct hp_wmi_sensor=
s *state,
 		return -ENOMEM;

 	for (i =3D 0, info =3D info_arr; i < icount; i++, info++) {
-		wobj =3D hp_wmi_get_wobj(HP_WMI_NUMERIC_SENSOR_GUID, i);
+		wobj =3D wmidev_block_query(state->wdev, i);
 		if (!wobj)
 			return -EIO;

=2D-
2.39.5


