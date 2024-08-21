Return-Path: <linux-kernel+bounces-294749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7730959204
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 03:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3C6284B71
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E991C6B5;
	Wed, 21 Aug 2024 01:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="Sz2RLLJv"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BF74A24
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 01:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724202318; cv=none; b=N7EK2GxtHCfMJgMo0dNJGBsgjQCI2Y/CXLzP8YpeBsnndgPSy12sGyzYT0fmXkpICPCO5o4GYOWgQ+/NNGVI6iBkhfQ16X/sbDR6t8kuzQUNDsaS0NHd7yippk5VqufrLW2PyqchpfMHMK9X0zvLoZb9DKi8TtS7okes+9hCnJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724202318; c=relaxed/simple;
	bh=CRN1qjp6GM97aDt4ocZGShQq+C2mevpDFi2GMoV168E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5h+OfM0ObL+f+FHBlZD+DWt1mBIAFABos0Q02wc09UgLg8VEQxAk368O5WizoErBEEmlt+LeJ8IKGU55eQZ3agPRHexM0Ig9IXe1CqTxKISA/8LjoaP9l6+oSwUjuFTYbWGoEndCEThk7UaHluxLjrUr/adRF0xFkg3m/uJnno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=Sz2RLLJv; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3db51b8ec15so143740b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 18:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1724202315; x=1724807115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ICGVYcRkqiB0693PxDmpHHma2Q+GoypXmxF0cjKnkM=;
        b=Sz2RLLJvSazT9dQTjjuHEEJh5Xv5SMnXFPh+O5W6OUk0k72ldy1fwKgN4ZkU9DO3ug
         fTuP5PdMgQEs9SRIj4qxZjnjRkG6NhheavA6NIEphgypyOx1hEaSNS+46KGxhK30Tutz
         Mwt4k/CEC/RTEzjowf6ux02Ss2g7P71MInY+Gy2REdHedL3j8UVb3awj07MK9J9W93r2
         /q193IHw55I/UjLFmU3XqRpzC/qQLWUmk9qE+U/wpM4RVFMIyrdHnSjUpPsDF3F1WS4p
         1IPBVmPPZxllXyK+Z2chf6RT8KNiBZI9SRNJyLWQty7wzkrY4SqvEkEQkST3Km+JCuYz
         GKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724202315; x=1724807115;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ICGVYcRkqiB0693PxDmpHHma2Q+GoypXmxF0cjKnkM=;
        b=lx0wp0VZM5Jjsu+XZz8/kFvffUeDDHbIhR1KD1bMu+3f6kqXh5JZh0SkDVSPbjdy5g
         XpS2v2CxIzKsb+nvSqgGOtCq3ytG0qyCD/5JLNi0BWMwFCqYlupgFDKCNQ+JbWikY3k2
         +wc3eB3hhERwyssZt2cyIXWsbnXNzjQNg4wSHXV721ump/ciaNBatY1GGpd5530QCzgj
         5Axn8Tdm7WAobnNymtaIMAnje/jxHlUiOpgW0l5YQKWD4Qnk/MhBJFxNicrNtQYbGEQy
         5FXmZrRhtw9eu195sXJmEGBkC3fwOoayfutBRJ/SGdZDgceczd9iCe03lQxbp+o4ZuSx
         2cfg==
X-Forwarded-Encrypted: i=1; AJvYcCXH17534pbGQKmgTZV3CWN4GOUg1ctRX8XG0/ywbDytu3GeP38SPet30DsSv/KePaIXdfooP7qGtYMrIeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqFelmNroMShzI1KWunsjBnC8+glgZJmPEkGeQi2auEcYEUzvU
	RtTTOgYmwMHBC4/9B2cSgsLBxgROCM+ZZQ/jM6tf/9VZLscoQo4yPFEeJzcFriY=
X-Google-Smtp-Source: AGHT+IF/Y/1GPSasXn3CRcQ8KFCuuUJT9SPTwnxsx27s0DXbOwypPL0HFBlY5I0DGL6GhUJuQx7c2w==
X-Received: by 2002:a05:6808:23c1:b0:3d9:3e6f:ba07 with SMTP id 5614622812f47-3de1a284b8bmr332156b6e.3.1724202315395;
        Tue, 20 Aug 2024 18:05:15 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:be34:fc2:a1be:3f67])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dd33d6254dsm3129646b6e.20.2024.08.20.18.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 18:05:14 -0700 (PDT)
Date: Tue, 20 Aug 2024 20:05:13 -0500
From: Corey Minyard <corey@minyard.net>
To: "Ivan T. Ivanov" <iivanov@suse.de>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] ipmi:ssif: Improve detecting during probing
Message-ID: <ZsU9SRlQgzQn8bDs@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20240816065458.117986-1-iivanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816065458.117986-1-iivanov@suse.de>

If an IPMI SSIF device is probed and there is something there, but
probably not an actual BMC, the code would just issue a lot of errors
before it failed.  We kind of need these errors to help with certain
issues, and some of the failure reports are non-fatal.

However, a get device id command should alway work.  If that fails,
nothing else is going to work and it's a pretty good indication that
there's no valid BMC there.  So issue and check that command and bail
if it fails.

Reported-by: Ivan T. Ivanov <iivanov@suse.de>
Signed-off-by: Corey Minyard <corey@minyard.net>
---
 drivers/char/ipmi/ipmi_ssif.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

Ivan, is it possible for you to test this patch on the broken system?
It should work based on what you reported, but it's nice to be sure.

Also, I discovered that the detect function is kind of bogus, it only
works on an address list that isn't present (any more).  However, I
re-used it for my purposes in the probe function.

Thanks.

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index e8e7b832c060..4c403e7a9fc8 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1368,8 +1368,20 @@ static int ssif_detect(struct i2c_client *client, struct i2c_board_info *info)
 	rv = do_cmd(client, 2, msg, &len, resp);
 	if (rv)
 		rv = -ENODEV;
-	else
+	else {
+	    if (len < 3) {
+		rv = -ENODEV;
+	    } else {
+		struct ipmi_device_id id;
+
+		rv = ipmi_demangle_device_id(resp[0] >> 2, resp[1],
+					     resp + 2, len - 2, &id);
+		if (rv)
+		    rv = -ENODEV; /* Error means a BMC probably isn't there. */
+	    }
+	    if (!rv && info)
 		strscpy(info->type, DEVICE_NAME, I2C_NAME_SIZE);
+	}
 	kfree(resp);
 	return rv;
 }
@@ -1704,6 +1716,16 @@ static int ssif_probe(struct i2c_client *client)
 		ipmi_addr_src_to_str(ssif_info->addr_source),
 		client->addr, client->adapter->name, slave_addr);
 
+	/*
+	 * Send a get device id command and validate its response to
+	 * make sure a valid BMC is there.
+	 */
+	rv = ssif_detect(client, NULL);
+	if (rv) {
+		dev_err(&client->dev, "Not present\n");
+		goto out;
+	}
+
 	/* Now check for system interface capabilities */
 	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
 	msg[1] = IPMI_GET_SYSTEM_INTERFACE_CAPABILITIES_CMD;
-- 
2.34.1


