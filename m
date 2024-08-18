Return-Path: <linux-kernel+bounces-291082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74026955D06
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 16:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5D71C21270
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 14:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6777C83CD5;
	Sun, 18 Aug 2024 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="DzwSpjmB"
Received: from sonic315-13.consmr.mail.bf2.yahoo.com (sonic315-13.consmr.mail.bf2.yahoo.com [74.6.134.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671702F4A
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.134.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723992642; cv=none; b=PmpNOikjFHo0LOtT8yNCuPJ1gz/PBkzvJe+NEJXSvTAEnrw0iZRUF8SdzQflzJaQlGG6bqoSGM4Rjoj4JZmA0OPsNEo/L171FIHpA5/00LMEXCKJyCPAh1Gab2+iKHde7LoXKuWsbDGH+Ol5OvhnpwypQwxeRRiV8fnwpUSGQSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723992642; c=relaxed/simple;
	bh=IlcJ7DAXJughqqgs9p+qQ/Dm9rm9/sHNVP8LIP4LqFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RoFIdxJT7Su1SEhYbDG4cMy3Aa0vfNArsdWyOZTfk6Pdzo24Wm6WDRW1QCQdkbQbyuph/XhwRgNCVUwrGY7UGB4Uikw5S6b54im4P2o7hfsF9FXTp3wRFAs5DGbmplY13LajQjULY3GXGO8ND8B/J9YiLIDumZKa5vYGCkCFBgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=DzwSpjmB; arc=none smtp.client-ip=74.6.134.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1723992639; bh=GvmK2ugEmetllK+utxDldOduFldKR32XYFgiKkFWeUk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=DzwSpjmB2KGusabIQ3o3EgPyt3IkaDvCQUUO90OdkmSFK6KHNYtMi8Qj43oBLU4fu5PtuNKKLWtH1cYHndOyJLueCmi8jwszcce4AkPuUKf1KSs4x9Ykjc2LHeyAAjLdz+qUsqilkKROzoKjCZRR9c9bompL/rA1Ta7q7p8E7j/KTaAdQ6u8L/F/+UGvw/6t76KGFWMqin0zmricODTztOA8O05l2ZsnIR48SfNq1BD2eY+uJG99Dz5WgoOSJ3CBZ9v6+LkHLJ+kXtHzBIm4B1WFlY95EnBIQIcdFUmDKj5spmuGBYPpC2DwF7mD4y09xERgQ6COloA3c7ETtUXuYQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723992639; bh=g81Y+l0gR3uu8fSNVaeJUfuWh0p4Dw2I5L8h945difb=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=SJ6+Q+SgeFuIJJaSOjoPkXy3VjaJ5O4TJn44RV6bsRmIcTH50u2fx25/EFhoAs+5+SHViUOkViTdYrw1dKMqrMEgRlhy53mTO/wZsforZXgtGGdwLLOltMvBDsnCg7HHerl4lMgDxZHDFPqENaGu9hNnX1WnhBC1v8ZZNKJJ1cb/PmkLkahwUX2WPrYlERT/bglux43V6Uit+a9EF+af9mYjn9WjN59hn4bHFQ2L8sAa14pXZBWKh7Bssiuj9dsliKSOVYCs8ojpT2qcOsTIYxX6V4kBp+NuQWT/JTScNT8ceP7kpRLPQ2VcxkBAliWlB6Pzlq4qFh/r2uQ+1gZ1qA==
X-YMail-OSG: eFgF6eAVM1n_YcKXUGtxOWg6BqoD90F2hp9y1fAfCUIKC1wCMmAy8oeW701AmiE
 V3i8E6QzrfeRu8U5.0CmzzMtGFz6scYHCJCkqaI64_QjIdqfsyENyY3PLGqtKX83C8io4HWwy7K3
 AxHGPvsl5VvOgcl5vP_4EVcylIeH08xYOkg2zTcr3fWvzivkghkeHQkcPMK_3dtCSeY_wNcS0oto
 JYCmyHI_RjBb2Q9kPOi4Gn0J7l0tQt6zLEvglzSTVvZWTkpG.Z5_pJo.gtsVXYSrsqDgZUJBmmUE
 0UJkORj5.S9j5aGlSjynRI46Bjvhfs0tWDLxUbohb_cQq1H4NtWP_k.21Ys4fpXkG7XGK1P2SRPr
 0RDPw5rQpqMT3FZ5pwhjwNv8zMdmsa.Gm3JumhJhvo9svQZi1_zjMRvMZ3XaWJiVBadYqr5gL7bJ
 LLiXRUykg56cH8EPoisufR.KYIWV1l06PljDNWwHrcXx0UcacWEtcZ3uBxi5.K11Gh1.i0Sc1k7P
 epxpcS4chX778ul3MZZV4DjGJQvDDArViABr_gWV.czY_pnr52qdVpbjV7pOImTJJp9GLeBND26y
 84ECszPqog0Akzvr8c3Lw.mpQpUbVqJsqKrImeYkaYKlHdUAi1NkpFtX3RJkXw5arSBiGL8eoVjR
 KQDVE5iwI5AI0DCYfqo8IVIKzTVwmZEUG0uH44doHUZgS40DaJ.NtNwUVw3HvSUldpqDJxElNMUf
 eR8WH.xHkXvcnKwN2U4uLTScORL0jgCXx7N5GvZbgtiMmaW9do4cSoKWi_Gh2Y2aQCJfl4TGm_9V
 JQlBN2OzxPK_5n2VSy5A9GBv5pALF.btCxeERCqLYgbtuH5Y4fAJ9e3S5pmcEevvu1VQGykdfIuE
 G2UjemQSpe7AzJuKMIYm18KM1A6akq1Wu_iQsQcWVKCH9eLE2vW.bAreodyxq5JsUVlRqyc_84qg
 OHOg5QijnXfCKYMgPRtIqPp1yu0VxFpg_ohw2S7Ttwc_e_17JaSLOpj10a_tBwKRTxsU9FU.Hxpw
 ORkGP32wF0rGRc8QwgzrVn01Mv1S0c0tzkeJj9UF_UKvj8OrnqjrokdGeanXnE_TQFyS60K3lbz.
 wgJ4wL2CzkoIAtQapwRDgwGhfUkUqkBud6L03nLXwJCIX3duYLE4t2XCZSDBFZuWFN0OAzY_J9DF
 rh51MdMFWmcGaPZBbxH6TybM2ypRu515xZ9WNRHynuG1KnnRfMxctRFJPUM4VUepuAR7Mkni9gm_
 X_2.FvWZy0nB1wrfL7waFH3f8IA3l_GOTVddfdXBrzrDekskyf6tN41a6M7YloGNO4juxjNql3vz
 cabnDBr4UuL3cEYaevqeEeUAE6oDaRxnQZr1T7_mDuPkWWgOoIk3uijpHtRkRaKGdZJOA1bc4y6u
 TU.FkZsPkMkJPIGKTJVnvj3nb40j4VDP_ByNpSv9VcVb5xWvJKKjyf1IQRa3KRl7O3sArebe.it5
 tmbmlwsGUPHtdXcD_mXxsjmf29CYgGq8S_Q.E4743G3p_AQpgacLyKs.90k5aaE2x2jJI7WWzokq
 POQ.UhTGq0De1xQTYYoHyEPJbjtx3LbTrIqCHwru267Rs7eXjf4eDspw.HAXYqLViRmK_nFyK5QW
 T4hx8NKlPWIInVA3PwjuV9wgotgxEEWjR2n8.Xf5RY1OjPwt9NUS5d8MIxq0v.50qq07QxZVVkz8
 uhz.puHffpOdBIEekIqrtj_ZtX1VHQST2mW6qXIgJj100P2qB_XH7i4mLZtYpE1YRQ7uY8Bxo.qU
 cfTVJmfn46u3ueEwKw9iAKqEdSkCt87zm9X2jSb1D1t5UBuPgudYnWLC9Bx_xEjpUj5Kcfv7LIci
 RjBanGrQL6jAjT3wl8gY_KBM8rlo0lQgTuGvf4JnaO9h_gbl6Q49MsLE6Nkq.rRcp11RpEp6YhGN
 lJK0cPQHdQMHEav44USePSWB00MFb7.fezJcnN_F8hIh72iZo2Q93KNbdzy5oIRbuw4pEPLIIh_h
 zR.AxnXw3.MytYoRLpEFgvXLRYOhfE4CHRL7N9OyQZXkIY.l07dL3Yk6DF7f7oBfKV_ExbJ3NfIB
 flj6wcNd_ySqSkH2HO2pckhfJ57Du_xcjKFFdBpU9rCNVdrbyu4Yq7iCY2QWrjY4JX7vXehI0QZ5
 PAuhk9q3I9tRA3lxwC46Ug7.MizZ_roudUmzDNJyBsXpbfuYjQrDdWdbOhPdoXP1OuZkZU3PLp8k
 THtPbAIL0crOYwV3ww4xQU6IxSiZfA9m9llV7eSy3_iOod__D1KT5wCKQCDNr8YIbGP0LX7knQua
 BCzT0Rg--
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: e80fb5f8-b193-4644-b4f5-539bc17b0161
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Sun, 18 Aug 2024 14:50:39 +0000
Received: by hermes--production-bf1-774ddfff8-xth2h (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a897091e1f8a4ddc26c454231bb7095b;
          Sun, 18 Aug 2024 14:30:22 +0000 (UTC)
From: nerdopolis <bluescreen_avenger@verizon.net>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: pmladek@suse.com, rostedt@goodmis.org, john.ogness@linutronix.de,
 senozhatsky@chromium.org, tglx@linutronix.de, tony@atomide.com,
 linux-kernel@vger.kernel.org
Subject: Re: VT-less kernels, and /dev/console on x86
Date: Sun, 18 Aug 2024 10:30:22 -0400
Message-ID: <1947584.IobQ9Gjlxr@nerdopolis2>
In-Reply-To: <3669532.hdfAi7Kttb@nerdopolis2>
References: <2669238.7s5MMGUR32.ref@nerdopolis2>
 <2024081824-leggings-omission-562a@gregkh> <3669532.hdfAi7Kttb@nerdopolis2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: WebService/1.1.22544 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Sunday, August 18, 2024 8:33:25 AM EDT nerdopolis wrote:
> On Sunday, August 18, 2024 1:12:14 AM EDT Greg KH wrote:
> > On Sat, Aug 17, 2024 at 08:09:20PM -0400, nerdopolis wrote:
> > > Hi
> > > 
> > > I originally brought this up on linux-serial, but I think it makes more sense
> > > that it's part of how printk console device selection works. Without VTs, while
> > > most software is able to handle the situation, some userspace programs expect
> > > /dev/console to still be responsive. Namely systemd. It calls isatty() against
> > > /dev/console, and since /dev/console on VT-less systems currently defaults to
> > > /dev/ttyS0, and when /dev/ttyS0 is disconnected, the ioctl's fail, and it
> > > refuses to write log messages to it.
> > > 
> > > There doesn't seem to be a mailing list for printk, so I had to use
> > > get_maintainer.pl. Hopefully this is correct
> > > 
> > > 
> > > After some grepping and guessing and testing, and playing around Something like
> > > diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> > > index a45d423ad10f..f94a4632aab0 100644
> > > --- a/drivers/tty/Kconfig
> > > +++ b/drivers/tty/Kconfig
> > > @@ -384,9 +384,12 @@ config NULL_TTY
> > >  
> > >           In order to use this driver, you should redirect the console to this
> > >           TTY, or boot the kernel with console=ttynull.
> > > -
> > >           If unsure, say N.
> > >  
> > > +config NULL_TTY_CONSOLE
> > > +        bool "Supports /dev/ttynull as a console automatically"
> > > +        depends on NULL_TTY && !VT_CONSOLE
> > > +
> > >  config VCC
> > >         tristate "Sun Virtual Console Concentrator"
> > >         depends on SUN_LDOMS
> > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > index dddb15f48d59..c1554a789de8 100644
> > > --- a/kernel/printk/printk.c
> > > +++ b/kernel/printk/printk.c
> > > @@ -3712,6 +3712,11 @@ void __init console_init(void)
> > >         initcall_t call;
> > >         initcall_entry_t *ce;
> > >  
> > > +#ifdef CONFIG_NULL_TTY_CONSOLE
> > > +       if (!strstr(boot_command_line, "console="))
> > > +               add_preferred_console("ttynull", 0, NULL);
> > > +#endif
> > > +
> > >         /* Setup the default TTY line discipline. */
> > >         n_tty_init();
> > >  
> > > 
> > > 
> > > 
> > > seems to work, it conflicts with CONFIG_VT_CONSOLE since it is effectively
> > > redundant, it is optional, so that it doesn't cause any changes to
> > > configurations, that historically had CONFIG_VT_CONSOLE turned off in the past,
> > > and for bootloader configs, it won't change any behavior if the kernel command
> > > line has a console device specified
> > 
> > What is wrong with just setting the kernel command line for this
> > instead?
> > 
> When they eventually start shipping kernels without VTs, they will then have to
> include a script in their upgrade process that runs
> 
> sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"/GRUB_CMDLINE_LINUX_DEFAULT=\"nomodeset /g" /etc/default/grub
Ugh, I meant
sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"/GRUB_CMDLINE_LINUX_DEFAULT=\"console=ttynull /g" /etc/default/grub
sorry
> 
> (Assuming they are using Grub)
> > thanks,
> > 
> > greg k-h
> > 
> 
> 
> 
> 
> 





