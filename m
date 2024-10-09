Return-Path: <linux-kernel+bounces-358011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDAA99792D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DBDC1C20980
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3D11E47C8;
	Wed,  9 Oct 2024 23:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b="CnTlf6dF"
Received: from sonic307-22.consmr.mail.sg3.yahoo.com (sonic307-22.consmr.mail.sg3.yahoo.com [106.10.241.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E70E1E47BC
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 23:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.241.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728516999; cv=none; b=THG7nvZXLKAPKQXbwcwcLbGpKxXvv1cUTPXsOBEJkzoTIcVbHm6HGN24uVVSrorADGvbEnlAM8yNCD6DiaueOrGcJNQ6szBkrn+79SB7bWBvTplFxOfnJby+FjE0ltmlyO8dGZypPKS9bJ/mKUQeWVgax9bvTgx9HjAJeE/lvLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728516999; c=relaxed/simple;
	bh=cfaRjA3CqOTxRD7nUUWHlYZv23A9SpOnzpBVDTYyXQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=e/gnxMX6hzGP/r1yTGiSWg4pUHwkEMHqOw1Kmfr2GLQuPkAnnJF8uq1dxTVRs8Ao91A91SI0H2vNXB2GbekIBdf9Zm6CrK7Ac1aPWrtSqhEl6DqTAEPqs0oNJIwUPO9yBaft9UOHHDoxn+khuk1H6fXPEIgmg/TIHEfV3HX6/0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com; spf=pass smtp.mailfrom=myyahoo.com; dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b=CnTlf6dF; arc=none smtp.client-ip=106.10.241.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=myyahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myyahoo.com; s=s2048; t=1728516995; bh=fCwkOM8TYV+wxIKhbJq9MIh4fDUJOApi7mvbAmFs+6I=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=CnTlf6dFkAqQFGiNaZe7/iZkmf9BzVjRBDVE4YnsBNcc91bJS6ZevoQiXSYv6GICijTk6Q6CkzxUN9BUJXjYAW5zpdim856kYCiie0NXZ0CobkpslSgJ0UtbcBSuSlv71qKpSXX0fao+D58ZT7iPw4WNJ8SGrJSFRCSj3enyCGn9Pa8kPs06NANwDybJMbESNX5AhE47FyIQxR1l5yP7kJ0OEkmp5z5AAnH2kx4YpKH1qpFhPTcqyGthnXQ8iiucpWYVwOfeo8MkjMrtKxdwG4vcYxNEvGAPw9umE4WIvV5TvH5BqVCk6eBu83Tj3FJ9qsDGbLE3RxYJGBJR2SOgoA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728516995; bh=ht9mVBUIfi6xIV/vjX08MdpC3Mqx8vJ7P9LKhsX9hW+=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=sgtaw8FktSLFTvZNjGIJ8b643uv3p4mMxIek77M1QVWwRV9y8baMMzmSqk+44KhXRwVY/5N7nIolIeLh/ORSTKN91ZQjUoAeDhN2KR+idRGI5UVDpE0wd6KqIWY575wUEJoqppG3KqYAy5Sm4xQ1UoGjoH6/mYGIL4Vpt0a1PAz7f4/WXgC/CvMmhdtPao73upEEfrI0dmP9NqJ6MQVwri/VSrFMcDEL9lXaSGTB3bOgO1FZqYYxUcuIQeABpzM/5rYic9tzpQ63dtoEsPA6yDWkZoKDQ5a2KUh97LZPzRUZ9nmi6JwjLaVsXMlFaytS0filcd40mVF6ibm5GRQxrw==
X-YMail-OSG: LAqXbcsVM1nw4.MA3icLGCWBMgxXA9bNb.NaHzjvCRm.LhHrDpB3T2VXNy0JdBQ
 FvzvAuPOp_GmNhaQH64T.j9.2cpiBXJuYI5uGWCYhPtrA1O427LjcPPgcPjiJ3fSV1VvvgE2mAZb
 uh_ay_MGdD9GjtlxygN3NQ1WsK2mToUcxASu1F6nXtLUTvuCQU0JfmIdcWMU8mYfy9I_lnmqpd1o
 RoN0dc0RSU3OUPzCdS5bXVaL5cyh69fbgr72XGKEKG7qpBnCqWrBTwah4QUOgmiXQTJr0ucHm6cW
 p.38n.K.Sgk1w4RxYsfq9.xrxnMIPRN5XGoXKz9y.ilThJmDxX.KMvWfsi4mAkEw74jsD2Iv_lE3
 4bOGHnKi8rrFmBlSCGtgJrQlMwBAHbkjGFhgxwPtXFzTMLHw07r1NoPEwO1mrWxHhQBUkFBFpGf1
 4HW2N9ojBS2MRXNn8_.hMupuz0fOsQmxrZ8M3z7qJlueWn_l63wOT2VP26jItoUKY3RYDAS6_u5s
 092kAZH0JjdMMLmhn1xxRFN.fvEwxJSuVCmdsJvWesgoyEoXct0ywRXgUr5Z.klPXXZGV6QHOVSP
 x6DR8HZ_gZt9cm7vEBVBycdSzfAeLJsipd.y2A5rWEbEn2n6Ap0u.JuRCiZQVb55K2mqfajgbw2R
 QJvB09GTD_Vvnau8_OSovoctzBPpsDYPj6olyVyX4ig5znf9zjQsWacdNwM5EPJ05O3duhpWvwtb
 Aw0WC1v0cP7UmxzhTgxOwwFg8ocCuc3eEd0bdrtgXIoPBIb9GGjPfD5ZDbnzyE3mE3UWFvWACX9K
 o3THHua2BUI4Ayi8UPCSzreR3EmZKjcoMeSAu6utGwYRSHfFYnjWI1NHgTRicaF9wIffUB3rjKNp
 R7EAJCfb8dXi7wrjee2kWqzlzzOYKi0G_4kKPsh4PXlw0I5ARjyToHZAztZByeMwz3qE19qgPNXv
 waUP5_oQDm3fY7UWz5IDLyFMtwNI8xGtGRWMI7.lyflgMyfjWz6smbH2ibWNXyj0M0qR7SMw84FV
 G.SOpkv6MwDPkDTBZP7mLYK5580bagECkoU3sVlln8xTNWmvNIQyFt0U.YmjYy1eqs.VNl6MnOr_
 evGyqpvcpWRBixqxnQUwg6fdu7Dg3AubIo6g9cxJ9XJ5gPZaZLphQ_Ne_hud7O33d9vRwNT.03IY
 LgWedJQSlZmhleVzKtdD7fbuu_nnHJr0y5WnMHA7CZcixtDAbvxB9gJXhtvMtFTcRYEo0LS5I7t5
 zciOTgB1YzyNXCYRwRA_dxYn2yzG3e_nIw_y_r_mcF1shNMb2yWzA8nKxSdQ_8isg6bCMmyVDxjt
 SJN9bvf7upDlWHzxMCnUkQJiF7XMthl11PFK5jocccdGjtPGliHX6pSgZkpU7vIZZ26wTxlSfeeK
 qT9BDqLtJzGOalw4.2jCgDecIdWnDQm0zc.oPyPkjw2JYP5ZtbxcFg_N3qyKCO3GFKIBCNMZoTjG
 EeK2jPB3LUUYxiYNHc9rrabt4eRi8W5xFBBkvwcUdmYktjdgWRyQGFZnKDrw2ri_YLZogQxLcTuV
 xgUs7VYaGlay45DcsA8kbzIOWZhcOLGx6S7V_BgOQY7M3o7_AQIMEUtkeWjn1qWigFGKwBPVckDn
 WrWWNsMRXSIaL0B.VYyya4gbi3Ig2W_ivw3HxzrYWqo11ueqgjK8jZKneQqd9lQiX5UqB1y66OTf
 ly3gEm11EdkuIx11gpSE.azHHSc6SRz5un0e4lY6L1.fnkzpM4mUtoZufEFTNt4ANQAAVtgeoQLS
 84ontRuD716iiNLbrNjByJRwWS3shaaL6x1Il.cwFOxSH0LJcU0DVS3Kmq4aPN.57b4I3pDyi.c8
 D5bXpD54xIYNKKUrjjsTZ0OMjf0v8fax7BSukW1tTxyXPnpS93U9rFtRI_RFYMSXR4.mSsvx111v
 O0GU9cyPdMHouIB8Tu5L1x_F2XYtdUBlU9XxOOKHkq5sIWlnEiAdJxhZz8A_KYZU8HZCWyMw1VSL
 YSXd72K0juqRomEokkBN_wL0Hlms1J_ez237VR3YwXRyRYXeZcxAjkNsunBZvOxt0H3_ThDQkwqN
 3NpJxoyG__d8hsQkotEMt8pAcPYNK.4uGe2XP.oy330veJbPrR37o7TnIoYvl57pzbOq8RmoK0pN
 QVt_w3NLWusMXuOmN7W2W3LfTuaohqcai4ChdU5uzlvHIUD9EbgviM9mev40ddNppQm1IPUclojQ
 SgO7PQSLM3KeEG0wN5QjpdFvUpuC69UyUwYfX.r3hv7XLwp55PnbKt_b20OCyFQWsqA--
X-Sonic-MF: <abdul.rahim@myyahoo.com>
X-Sonic-ID: b416c6f4-eb5e-4393-99e5-d3f766167a5a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.sg3.yahoo.com with HTTP; Wed, 9 Oct 2024 23:36:35 +0000
Received: by hermes--production-sg3-fc85cddf6-qj99b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b4e7dfb9ad5f3db34c6a2dfeb82ccf54;
          Wed, 09 Oct 2024 23:06:09 +0000 (UTC)
From: Abdul Rahim <abdul.rahim@myyahoo.com>
To: corentin.chary@gmail.com,
	luke@ljones.dev,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abdul Rahim <abdul.rahim@myyahoo.com>
Subject: [PATCH] asus-laptop: prefer strscpy() over strcpy()
Date: Thu, 10 Oct 2024 04:35:58 +0530
Message-ID: <20241009230558.51892-1-abdul.rahim@myyahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20241009230558.51892-1-abdul.rahim.ref@myyahoo.com>

The function strcpy() is depreciated and potentially unsafe. It performs
no bounds checking on the destination buffer. This could result in
linear overflows beyond the end of the buffer, leading to all kinds of
misbehaviors. The safe replacement is strscpy() [1].

this fixes checkpatch warning:
    WARNING: Prefer strscpy over strcpy

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
---
 drivers/platform/x86/asus-laptop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 9d7e6b712abf..d460dd194f19 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -1832,8 +1832,8 @@ static int asus_acpi_add(struct acpi_device *device)
 	if (!asus)
 		return -ENOMEM;
 	asus->handle = device->handle;
-	strcpy(acpi_device_name(device), ASUS_LAPTOP_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ASUS_LAPTOP_CLASS);
+	strscpy(acpi_device_name(device), ASUS_LAPTOP_DEVICE_NAME);
+	strscpy(acpi_device_class(device), ASUS_LAPTOP_CLASS);
 	device->driver_data = asus;
 	asus->device = device;
 
-- 
2.43.0


