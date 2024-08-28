Return-Path: <linux-kernel+bounces-305715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD92963342
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C6191C23FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00FC1AC8AD;
	Wed, 28 Aug 2024 20:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAN8Nm/v"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D64F17C223
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 20:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878678; cv=none; b=KQ1wd2plAu9LS2iZ+eTlACP700PeV/7+QK1p+xatf/T6DDWpRjVQ7VpmVzd0MfGAmj7NH8NgaVcL1vq5gyCxhCi8AsnbVH8ZalPQxMPaUxDZkd/h25U9W1/o/JGmV04Rse8jC7KK13CN7Jw/w4aZbMJ6bu7PdFF+usFxoF3JwvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878678; c=relaxed/simple;
	bh=gqPVyeIG9/P2lUhFvlSKW1eLJpY2CvuinbtvVoEBEn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiSM4/l6A+3jynkkHFCLUEktsY5/PZiRQ+wwCpJZ12EBvF8E/S4HHwon1/y4CJk4EOakBvd9pD5h2zcWMZqc2JfPKihOFxqyW4wsueNAXnLW4CySbFro6yMhnRcnlTKWn4OyPrcHFcWZ29WAaxMTxtIxBh7grZgCLx3n3YKe9co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAN8Nm/v; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20230059241so62121455ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 13:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724878676; x=1725483476; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zhh9d4hqsn6IpDTfQczJRE05jETBWy/SNi5XXm2ptb0=;
        b=DAN8Nm/vt6G4G9FFmr75eAcSZnxXKexqZtDJLgmWdxX+UU8mHL/kusW5PATYTOn5YS
         2fPXxFa2dbkvcV6Jxa1OZevIMYKGG4uQWorL16TdJORPg3s68bH9Ec1KTI4jKAWPHGIO
         VyTIeYtMrVe5GLCKIz1BZ0WR3UeeSgY7nCa4xO6vufCZqpbsvHiTQtwZMK2626RqfwDO
         v292qEMZuLToGRxosnlYV455QmEbyiS5U34S6OkByiYSevrt1iV1q8Mo7h7u0oBNu3kg
         B7K6GcdWLiM4bbJ1BWEsU7Qs7hBMpw/uGllAhCiQZx/eT0eQG0bbxdIM6a926Hinrj9e
         lKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724878676; x=1725483476;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zhh9d4hqsn6IpDTfQczJRE05jETBWy/SNi5XXm2ptb0=;
        b=I+wYH1i2t9kSmBJ5QCiGI5y98nDd6i2qXMJvtKt0zb/H0bmYdEGo/Xlm3gxYYpM8Ok
         w2RtTjm0xa+lc1mdo2v309pZwkM/YvgQsCY2PkpMdhZAHkd7tWJ7SsDW8lclBtm2OA4b
         rSyI7HGEz5wJp7MBr8TrQ4IddaZU5Vu6OXOW20MNXFFXx/VGJiPjbrdTUVMguCyQoVVy
         QBnxXQ/pkjwzVyA2tnupoFTAHUjf+5Qaz9XdCEXuTt7koWY4mSPDMoUSn8kc+kV8OALD
         Y//D65Km/cYN1g1V2PCDAwbL4ZZEvxc9bbhL8iqONP3Jy+JSp5SqizX5JasvGyQUkl3z
         12yA==
X-Gm-Message-State: AOJu0YyD6OBZ9COwVCEvMtc6LHdVnnf8Pr+hp9P26Cw5V80VWNN6lKDk
	WobOiop3VTeK8GNSvdcKjnWaZE/YePA4SPKMo5pF+HCZ9aFtB7ixzQNOlQ==
X-Google-Smtp-Source: AGHT+IHJz4zFX0i6AnxLzx/kiuy97x+0zUHmwZ8SXktIlFDVpXFsjfozMx+j6n0s5ms9BgW3ZDZ1PQ==
X-Received: by 2002:a17:902:e552:b0:1fd:6c5b:afbc with SMTP id d9443c01a7336-2050c4bcd45mr8620045ad.49.1724878675291;
        Wed, 28 Aug 2024 13:57:55 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:3eb8:762:d1b6:97f9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557eec1sm103276925ad.91.2024.08.28.13.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:57:55 -0700 (PDT)
Date: Wed, 28 Aug 2024 13:57:52 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Woody Suwalski <terraluna977@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mouse_cypress_ps2: Fix 6.11 regression on xps15z
Message-ID: <Zs-PUNQI6SFWH6s_@google.com>
References: <a8252e0f-dab4-ef5e-2aa1-407a6f4c7204@gmail.com>
 <Zs55AWhUEts-uJ5B@google.com>
 <11bb84ed-4902-b993-57b0-26ad233942e4@gmail.com>
 <Zs93TGkl_ZMjHHAd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zs93TGkl_ZMjHHAd@google.com>

On Wed, Aug 28, 2024 at 12:15:24PM -0700, Dmitry Torokhov wrote:
> On Tue, Aug 27, 2024 at 10:46:11PM -0400, Woody Suwalski wrote:
> > Dmitry Torokhov wrote:
> > > Hi Woody,
> > > 
> > > On Tue, Aug 27, 2024 at 07:44:12PM -0400, Woody Suwalski wrote:
> > > > Kernel 6.11 rcN on Dell XPS 15Z:  touch pad has stopped working after the
> > > > patch
> > > > 
> > > > commit 8bccf667f62a2351fd0b2a2fe5ba90806702c048
> > > > Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > Date:   Fri Jun 28 15:47:25 2024 -0700
> > > > 
> > > >      Input: cypress_ps2 - report timeouts when reading command status
> > > > 
> > > > It seems that the first communication is with an invalid packet of 3 NULLs,
> > > > and that
> > > > status failure used to be ignored. With the above patch it is now returning
> > > > an error and
> > > > that results in a dead touch pad.
> > > > 
> > > > The fix is to stop flagging an error for 3-byte null packets, just keep
> > > > ignoring them as before.
> > > > [    2.338016] [    T591] err: Command 0x00 response data (0x): 00 00 00
> > > > [    2.338032] [    T591] ok: Command 0x00 response data (0x): 33 cc a2
> > > > ...
> > > > [    2.770029] [    T591] ok: Command 0x00 response data (0x): 33 cc a2
> > > > [    2.998030] [    T591] ok: Command 0x11 response data (0x): 01 00 64
> > > Could you please send me logs with i8042.debug=1 kernel command line
> > > option please?  I wonder if we need to wake up the controller...
> > > 
> > > Thanks.
> > > 
> > Sure, the dmesg log is attached (for the failing scenario)
> 
> Thank you.
> 
> > [    0.000000] [      T0] Linux version 6.9.0-pingu+ (root@DellXPS15Z) (gcc (Debian 14.2.0-1) 14.2.0, GNU ld (GNU Binutils for Debian) 2.43.1) #24 SMP PREEMPT_DYNAMIC Tue Aug 27 22:33:33 EDT 2024
> 
> This is not 6.11, did you patch 6.9 with cypress patches from 6.11?
> 
> Anyway, the patch you posted does not make sense. You are doing the
> following check:
> 
> +        if (!(pktsize == 3 && param[0] == 0 && param[1] == 0 )) {
> +            rc = -ETIMEDOUT;
> +            goto out;
> +        }
> 
> trying to ignore "all zeroes" response from the device, however at this
> point param array does not contain data from the device, it always
> contains all zeroes because of memset() a few lines above. So in effect
> you always skipping reporting timeout.
> 
> However I think cypress is busted in general as it looks like it times
> out all the commands, because it tries to issue them outside of libp2s,
> and so noone is actually wakes it up when we get enough response from
> the device. To prove this could you please try applying this:
> 
> diff --git a/drivers/input/mouse/cypress_ps2.c b/drivers/input/mouse/cypress_ps2.c
> index b3c34ebcc4ef..8c0c7100aa4d 100644
> --- a/drivers/input/mouse/cypress_ps2.c
> +++ b/drivers/input/mouse/cypress_ps2.c
> @@ -115,8 +115,9 @@ static int cypress_ps2_read_cmd_status(struct psmouse *psmouse,
>  	if (!wait_event_timeout(ps2dev->wait,
>  				psmouse->pktcnt >= pktsize,
>  				msecs_to_jiffies(CYTP_CMD_TIMEOUT))) {
> -		rc = -ETIMEDOUT;
> -		goto out;
> +//		rc = -ETIMEDOUT;
> +//		goto out;
> +		pr_err("XXX looks like timeout\n");
>  	}
>  
>  	memcpy(param, psmouse->packet, pktsize);
> 
> and let me know if you see "XXX looks like timeout" multiple times
> during initialization (essentially for each extended command issued by
> the cypress driver)?
> 
> Thanks!

And I wonder if this fixes it properly:

diff --git a/drivers/input/mouse/cypress_ps2.c b/drivers/input/mouse/cypress_ps2.c
index b3c34ebcc4ef..9446657a5f35 100644
--- a/drivers/input/mouse/cypress_ps2.c
+++ b/drivers/input/mouse/cypress_ps2.c
@@ -91,48 +91,6 @@ static int cypress_ps2_ext_cmd(struct psmouse *psmouse, u8 prefix, u8 nibble)
 	return rc;
 }
 
-static int cypress_ps2_read_cmd_status(struct psmouse *psmouse,
-				       u8 cmd, u8 *param)
-{
-	struct ps2dev *ps2dev = &psmouse->ps2dev;
-	enum psmouse_state old_state;
-	int pktsize;
-	int rc;
-
-	ps2_begin_command(ps2dev);
-
-	old_state = psmouse->state;
-	psmouse->state = PSMOUSE_CMD_MODE;
-	psmouse->pktcnt = 0;
-
-	pktsize = (cmd == CYTP_CMD_READ_TP_METRICS) ? 8 : 3;
-	memset(param, 0, pktsize);
-
-	rc = cypress_ps2_sendbyte(psmouse, PSMOUSE_CMD_GETINFO & 0xff);
-	if (rc)
-		goto out;
-
-	if (!wait_event_timeout(ps2dev->wait,
-				psmouse->pktcnt >= pktsize,
-				msecs_to_jiffies(CYTP_CMD_TIMEOUT))) {
-		rc = -ETIMEDOUT;
-		goto out;
-	}
-
-	memcpy(param, psmouse->packet, pktsize);
-
-	psmouse_dbg(psmouse, "Command 0x%02x response data (0x): %*ph\n",
-			cmd, pktsize, param);
-
-out:
-	psmouse->state = old_state;
-	psmouse->pktcnt = 0;
-
-	ps2_end_command(ps2dev);
-
-	return rc;
-}
-
 static bool cypress_verify_cmd_state(struct psmouse *psmouse, u8 cmd, u8* param)
 {
 	bool rate_match = false;
@@ -166,6 +124,8 @@ static bool cypress_verify_cmd_state(struct psmouse *psmouse, u8 cmd, u8* param)
 static int cypress_send_ext_cmd(struct psmouse *psmouse, u8 cmd, u8 *param)
 {
 	u8 cmd_prefix = PSMOUSE_CMD_SETRES & 0xff;
+	unsigned int resp_size = cmd == CYTP_CMD_READ_TP_METRICS ? 8 : 3;
+	unsigned int ps2_cmd = (PSMOUSE_CMD_GETINFO & 0xff) | (resp_size << 8);
 	int tries = CYTP_PS2_CMD_TRIES;
 	int error;
 
@@ -179,10 +139,18 @@ static int cypress_send_ext_cmd(struct psmouse *psmouse, u8 cmd, u8 *param)
 		cypress_ps2_ext_cmd(psmouse, cmd_prefix, DECODE_CMD_BB(cmd));
 		cypress_ps2_ext_cmd(psmouse, cmd_prefix, DECODE_CMD_AA(cmd));
 
-		error = cypress_ps2_read_cmd_status(psmouse, cmd, param);
-		if (!error && cypress_verify_cmd_state(psmouse, cmd, param))
-			return 0;
+		error = ps2_command(&psmouse->ps2dev, param, ps2_cmd);
+		if (error) {
+			psmouse_dbg(psmouse, "Command 0x%02x failed: %d\n",
+				    cmd, error);
+		} else {
+			psmouse_dbg(psmouse,
+				    "Command 0x%02x response data (0x): %*ph\n",
+				    cmd, resp_size, param);
 
+			if (cypress_verify_cmd_state(psmouse, cmd, param))
+				return 0;
+		}
 	} while (--tries > 0);
 
 	return -EIO;

Thanks.

-- 
Dmitry

