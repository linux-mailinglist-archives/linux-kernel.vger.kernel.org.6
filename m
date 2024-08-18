Return-Path: <linux-kernel+bounces-290881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CD6955A76
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 02:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3570F2822F5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 00:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA482581;
	Sun, 18 Aug 2024 00:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="ZXDhn9wk"
Received: from sonic308-3.consmr.mail.bf2.yahoo.com (sonic308-3.consmr.mail.bf2.yahoo.com [74.6.130.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AD01FAA
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 00:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723940387; cv=none; b=UpnOHAQ2vsUB/iOhwg81sqmXCGlm6yk2Ey481+bEBafy3JhdRIuUbdg7FmjPSMTHAYKQWBFXcVO58odtSDYhkJSmnbKVsdwD0p4bv/JMSBl7TTS3UlW9ru65MtJdYljtbWH/BpXHxobfM2phbB9H64+4S5TX+JkPusgmICTg+cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723940387; c=relaxed/simple;
	bh=sFoQP6FEAhTgEQi0SGAKBBSXRurNoJ8zlQRwSTo1maI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=E4P7RuPtO+MpZUTn1N0l7mxZrkVYUDNM8xUcD3vpqlPUs9kFHKNC2GFxXrnruTNLIuk2hB2AAka6LbcIW+8+ClrtEI9tUrdQAvo2JWJbGNpi8DQhV2dgeJUinu4bZnC1rVaS3xppS/W/KdF+a7Z94sfWrjxCmoU4/qbza5dlvLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=ZXDhn9wk; arc=none smtp.client-ip=74.6.130.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1723940377; bh=f493dutnwghSTgVks4fm+9hx1b/kfaAuSwfQVssWkq4=; h=From:To:Subject:Date:References:From:Subject:Reply-To; b=ZXDhn9wky+mZ3r1Kf/H44JPXS9fSYpYiYbDIndm/uOh9pDCVHzh+8UXn7OY6sl/QwUFPIAzjn/p4RKXYmxK8M0TeTdMr1MQIg+aIsaFooGZbFcHlrtPQfouHWaI2Pwy1yviqwdpMcIV6nf7oXuzQUgqIiVnYbFFJQ0kG299hgfVEbGsi7TYxcYlSlsBelajdMBqQWlPx2PFYtwS43mw6qB4CLUM7mrgYMRVhEiXlMJR6o+SAPOpIZLcSAqoYsZi7FXPeYJF+dBoYZUY9sO+g0HF9ZHLhGFs3We1WFlS3k5GG6mbr5tNOBYNHRDpgi9PlTHuzdfxFz6K56MeFjRINWA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723940377; bh=+GsTRn4oeT5UsXTUz5IGd2PpCV4xrjPiIG9pCAVwKkn=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qoatvR8nm2jq6lXMRqRHoh/MVdU40c4VV/2FDiAJGBCYuyzR2apXLM94CJlXydBH1i7aYFFmEYvs+gYTQbgQsb8gFJnhCQ/efIdoXMe9Oy6ZGb/3bvVo6xung0tfw2vOoy/l3wB7mt8OASM3Xq+SRuqveHetzLqGQVnmBbnUwXfwPlU2UkCC9jyRexLiPnlzTos1FnjqLC7MoppMix1hXXKHxA5K79EdaymwgFc1yshnHE5jwHwvMCPS1LTR2f2rq5HbrqzIgWPCMHidyhC8M5m7QyCJjRLGI2u7DUP7J3OHhZkqMEpBpVbuFK9815itR3aY62FLex0W12sYpwKDQw==
X-YMail-OSG: yrJbzrQVM1kBkTV_F6r2Rxp8S2Sl._.cu5oiYQAixjc5quLqDbfeKgQpOqqdQas
 H4GEUtSlOPhztZGS1XVTSJB8q2Fn_7qHP558_x132RGpUHX20X7PhKisaxxSSdnXOh6SjB9tfy4G
 zDRuqcn5yaCtnlqAb.58QlzdHlYKLKUXXd8aTQtXY.1X7CaNmHVPLbgObrIEg8qIGOPBfLCZDfTc
 2pyFvnZLoci7iPhrY9ElhhCSj5kB1I0gw_oeswuCm.xO_uvL2Wk86xCvxIE9CafS5CPh.Apcn9oP
 sjX_wXgxwNJYlbCgdkt9Z5M8rB5ruNKjHUIINq7DdXQSgYGc7tMKEgoFY9mRXqQS0zjUmyfXZ.QZ
 LV.konurbWhK2kQf_D8YAZmejDRITesw0XYzPEu3wGy6LPoQp95DAU.mAd77wBseMMzrtbE9jqpB
 j6Dd_qimH9yZWBH3DhBzkLvVdhF2wKK7vhmPuYx6PcsG6TjoBRzwm.PSD28jqIqE7Mf2KMmlE40k
 n5VTpHjISYPVCjk0Kq6XyHcjDL9FjJtJ389F.6fzYSP6a8edZbKg9d.uGEhp1yllFiBK1dsdEw5M
 ucVzCY_fZSI4vKnZx5nbrQWpCrYHoN60wCCGm69MLA4faM9i3P14hh9wmfHgJiUKlBTQYo0brDTZ
 YLoYCnCp.yLzs6PRUAARhMuSNRW3GY5YlcAG3G_1PSelwzuWd.4Kfg0XhAMqZnByeu.gG0nSBKVd
 Jrk2cILRYqx7Lb5WpC8wcBUaUj.E2PM9WHdF5GAhx8nRSH1CnVvrweb39UtJgrBlI84pf2CC_I0v
 ._Fsx9WTi10rMj9A5AlmYdo2qBX_4wKKidegPO__HluM0OHbcVmu7tTIx7UTkhBqzWPg6xgiFZPS
 w8kTIUidgNbMuUZ3Er4SzQ4KNzo2OiaUBtQN6.9fGsyrf9ymiJl62hq89W1iFsBnNlI.o3bHI8MG
 xnPRxCNmMJZvzVq7B0TaqExMaKQHSaKpy_bJejybH_790prZ3_kEZ8KFc0GmX.bjPubKNfjkg3C1
 eh_Q.xDwje1yTFFglCUUH7ROb7ykz4qhX4Rh6sv3aQvfXl2sp.Yr5A1TMQpgR6MenVLud6AgbY21
 TU3imkC6D7KvXEDjjAZsnHy7tM2mTq7JfAouNhiiVfU9i9AWU5KcXZ6cfE99DjB16vvdBF8e6hic
 JJAqau7q_SL4VPMGVqlWxT7TIQtuk1ypwQDzI6Q5DS0US9tslr6_h7M3FYssa9H5TxgntShjdzv2
 txa6bM_4B06bquWQvkrxk7ViK4YdZVZYAETYndkUkslVWB0Rt5Yah9ysb9lAWKuKCyoOzEsM.E5g
 AybaesPiHgOQmb4C7qNoVNWXObJHPamaKu2sE3zNlYKIoSvq.JuYgc3uuxqLEPA2g9dQszzYvUjq
 91XeT3uXLBhrtdIEXCUlwK6nvQDzyWhY.xjdM1izDB1ZZP1Pt7ZqKo6N05JANr3BBnYgpi44j2Qu
 9NaEC1kmQIxRTY0U3lYeeCdvoC6.U7yusliKD_38ptYklOrrf7Z3ZZrpdkqcSdy81pq6y5iCkA_U
 cjP6ig2NV1IMksXEqYFfowC9dbMHHKXObkBMT7c80bcfYBQj2GSK.tKMAqKtzND4YMn65fdejMwd
 ncAOhePlti6rRxIbvp_TRRdS9AiLK0wTI472LWq5FsYFepVVycR9STAZtui4lKHoj2gpHMz9jiYQ
 wrGU.d3zq8RgVEEISmN1CdNxqP2Rl2SGyZVxMmn2AF2zYSyBTnsWShkVo8yhOnFXA7YF1DRE_QC4
 Mp0z0SG4YygJxi87a.QOPeJ0LgGMrGBR5QzOZ3EU74ZGSbmF3nT4PKVyggidzfhaxBmOXGldx6Rn
 beScfLInet.KL8a9MKPCTp0.aNiT5dr1RmRVZxQEoFcAJL7wYxuvz03hDP0a0mzkMuyY3u7MKgsd
 tsLK83s32ANNS8TTahaNEJRCVinADI9gW9.88rx6A0Tw_eTeeWElptbpr3SkXM0PD1lECz0ZNjvw
 H.971PUV5xCrdIJUoMUJsBcTok6ZS_oESjl9sWmlz_1TFjwEGaOlVGAnykRybFbSihZF.H4C1x29
 K8XtJ1EUz4oJWIWqmct2iH.lf2jTMt5DRl30dvuZvUe0o.eQEKnmPPpDquWB9HtuBmL37cdOIt_o
 VTU8nLQsfa0_Ii39cdjamJZpqSWYJjCM3Hz7Nk54mpd0t7K4RFaW2QO3c0xFY6MdMhKfH3zwz.qb
 9_9ptpqfvKdSgrcKD38UfbdjgvhmRoMhz716tHR2NT78V.uPe_gR0L.erOFx.8D4Crvl.WR5mZVb
 JKoSKjQ--
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: 49b03a2e-156b-421f-9ce8-5db175a6b2e1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Sun, 18 Aug 2024 00:19:37 +0000
Received: by hermes--production-bf1-774ddfff8-nvh5z (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3921f1432360f11af80326769747f20a;
          Sun, 18 Aug 2024 00:09:26 +0000 (UTC)
From: nerdopolis <bluescreen_avenger@verizon.net>
To: pmladek@suse.com, rostedt@goodmis.org, john.ogness@linutronix.de,
 senozhatsky@chromium.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
 tony@atomide.com, linux-kernel@vger.kernel.org
Subject: VT-less kernels, and /dev/console on x86
Date: Sat, 17 Aug 2024 20:09:20 -0400
Message-ID: <2669238.7s5MMGUR32@nerdopolis2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
References: <2669238.7s5MMGUR32.ref@nerdopolis2>
X-Mailer: WebService/1.1.22544 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

Hi

I originally brought this up on linux-serial, but I think it makes more sense
that it's part of how printk console device selection works. Without VTs, while
most software is able to handle the situation, some userspace programs expect
/dev/console to still be responsive. Namely systemd. It calls isatty() against
/dev/console, and since /dev/console on VT-less systems currently defaults to
/dev/ttyS0, and when /dev/ttyS0 is disconnected, the ioctl's fail, and it
refuses to write log messages to it.

There doesn't seem to be a mailing list for printk, so I had to use
get_maintainer.pl. Hopefully this is correct


After some grepping and guessing and testing, and playing around Something like
diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index a45d423ad10f..f94a4632aab0 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -384,9 +384,12 @@ config NULL_TTY
 
          In order to use this driver, you should redirect the console to this
          TTY, or boot the kernel with console=ttynull.
-
          If unsure, say N.
 
+config NULL_TTY_CONSOLE
+        bool "Supports /dev/ttynull as a console automatically"
+        depends on NULL_TTY && !VT_CONSOLE
+
 config VCC
        tristate "Sun Virtual Console Concentrator"
        depends on SUN_LDOMS
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index dddb15f48d59..c1554a789de8 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3712,6 +3712,11 @@ void __init console_init(void)
        initcall_t call;
        initcall_entry_t *ce;
 
+#ifdef CONFIG_NULL_TTY_CONSOLE
+       if (!strstr(boot_command_line, "console="))
+               add_preferred_console("ttynull", 0, NULL);
+#endif
+
        /* Setup the default TTY line discipline. */
        n_tty_init();
 



seems to work, it conflicts with CONFIG_VT_CONSOLE since it is effectively
redundant, it is optional, so that it doesn't cause any changes to
configurations, that historically had CONFIG_VT_CONSOLE turned off in the past,
and for bootloader configs, it won't change any behavior if the kernel command
line has a console device specified

With ttynull as the console device, isatty() no longer fails on /dev/console,
systemd writes the log messages fine to /dev/console, and when Plymouth calls
TIOCCONS on its PTY, it is able to get the log messages.


Thanks



