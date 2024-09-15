Return-Path: <linux-kernel+bounces-330091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5364797999F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 01:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76A51F22CC7
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 23:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C54129E93;
	Sun, 15 Sep 2024 23:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b="ihuVGD8M"
Received: from sonic313-20.consmr.mail.sg3.yahoo.com (sonic313-20.consmr.mail.sg3.yahoo.com [106.10.240.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E489135A79
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 23:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.240.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726444441; cv=none; b=hEtY+L4EFQwbT/tZwC7mUyzIrgL9dYL9+Tpx4fMysHn0a7JjpfMHxnj9N+y0oQorD31csAEmLaBtweO4U8PwTDKJkD44CWs/0DHM+pL2yGP7JVzP7vWvOozoUIJN3fqdph6oBEb++JRFav+tyuKseS2uhLmWJb/4OJtYdVy3yFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726444441; c=relaxed/simple;
	bh=9uY9dnJYdRmdfJHWLQVeGdTVXDhPrHgVu1fL7C2K7aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggdPPAOiF+7tL+fVE2Xkmwln0WNI0LQlz1xMYZxAHPXbF6kNMvJ5rZnOFXObD+eeleGKiz1e7PXJm0rAzUL6xJjJigkqa1SUpo6ySz0SePUMSKdaPG/mzEoQjcSKvtsXSkhz2oiB+KomDOFY/DZvRL8okFOrLjybMeTy3fJqAZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com; spf=pass smtp.mailfrom=myyahoo.com; dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b=ihuVGD8M; arc=none smtp.client-ip=106.10.240.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=myyahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myyahoo.com; s=s2048; t=1726444432; bh=wBdRWLbOJLopRwjWrXe3U8vLG/Id5hy+7t6+P62KFy0=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject:Reply-To; b=ihuVGD8MbEMzONrbiedFTa3N318LLGqNFRnLTY7R0XfRapX3EzNgiI5TboikO3iNZIrpr4VoFJT/cphNirqIA7v9AiXzqqclZFALxESDrqKkkbp9wqbyViwCQQ72ywDf18ikNWcgYAz0Jlpr+du9NRD+ZHCpaUb6L7FhZEof69x8CYt+mn70oYeDII1d0l8CkcEh56xeWsP69yMRYWFNlNsxuIQaotPt21VyJpPkp0mUdm0a4EV4TWORUtRB0V1198+FUKAcsnAlCrUitFHeu+u858o0tFatAw4PdliiKt605Y9fbWi+5ScuNTbrqV+jc5SAoYRmRVKN2qAj7PQtbg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726444432; bh=CFtVdcub1pWDbp9tfHq5UOTIR+si1O1yxCYAJb8zh2w=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=fnMELHH2ZEXsLQJde9mx3rV1COaq8d/WkjLkWR0Iu7pwE9naUG6y7E2UYa8MmiGGNPJGkAFvTMFaZ/X6un4MJjpilHuq7L+BHk8SiFl97wsPyd6RxQ2MbJTgoyyrcOnVomNUmjVxMnNIXUkXKvaPpuMdXMeZR/BgOlXQvd3i+Bw8+bsb5fNMs7dYARHRMrBJey4WKW7eweudaQB+7TCj27NR2qZ88H3nB4MnUydVihtxnQrUAO55I/+Qn24s3LmDkMdayg8ac4K7igQj07AnSIVZpg7/GS9mqU9QgEYNlAwvO6IeS44APXTxJARJe+h6YCH/XkxJzZU7vDfjNv3Qzw==
X-YMail-OSG: b4GGUmcVM1laqwugOa4IQr.kZ368V8ZspjeniruPSXLrhjcF5p7csPERUE56rWl
 62wxcL10bhXRUDrqUQN8ihaCHyfriCgWKllJvvNbGOBjVVBPSdgxNsNXFX1vnb1SfgukjMzlxzkm
 ed.lS7laINQkydz6PVvhZ1XsmntzmIGAza_PAoEV5KrXxJgrRXgfjhpM85WcLAZr.HFi0jaNlcri
 jvRRI.EGh5SNWtE9my3.urChlbsAp5_ebJV87NU6O9gCvrQBhWPQR9IRY2yREtCABmrvW.lRl_2f
 KLFm1yz0GkkCVPQNfiGV_nfvTr7_f3e1fh0Ie5b8kAsnTNUjmGi5c.BJEny.tIB_iPNUQ.esD9sq
 RdLQeWKV8aJ90OZ1YQIUvlLAXy0b6tOIZsMH8ImyUKsarjvYIjGjE_lQ4.nubFNpC86PohDxPfRv
 l7bgf_KzKbIk7TQRcVr_KLRBlKvj2xBqTOq3Ho8wWHpmlO5uMeogINcICsCXzMfSF1FQ_qxAi04L
 Mnd9kIZ1xMlYsC_Etxd3es.lAvBUBB9ZXyYcLK04i3TUcSmxFN7NKiQc4pJGasd3uBn2sDKumTMn
 O2LW_Vy6ll27R.MGI2.ai4N97W9gZMl0OBHmtMnSU3KyjAZEOT4jlg6FjETlfUJRH8LDyuBU.7cO
 r2CGg5Nkg9eJovsCtT6neBNKieqZWcT80yu31ezd0We8vrndZC1g9W1IDfaX7Uxy_Z6snP6pp.Xm
 OvfqYcA4WZHqCGaUfhjGR6O0FeA2nAfZ.NcN7ndm0YRmDu92.zoXr8mcrzITOPSIL_9MxFaYJAt1
 s7NmQ2qQ_MLvs2xvsPk5BRmSmyBaPvZjvyp.dqnrgqXCW9yADbWxoYycwgRK8suUlnVa1qtguyPQ
 0Bu6ENVbCzrRlnpQySXvk_Xcx484U0C7uHdCctlwNj7u1HOJHA9Is4K5WQ4jpy_awT3mGuAuBEG.
 0znbwhpDrqz77zp4HsUiwdnGgy3TCHB9FgVjdzcUkxlLvUimqv12FoeEX9fhKN7iR5XZL.ro2Ui0
 7Mj6G6DgfTwXnHnvKfgscKrFSG4TrJKIgWunoSrrQAPNn7DArr7qLJJ.KWzY7GS0f_8M_NKJqAmR
 24brEkVqyHWAn9sz2PFEUtgYU_PaHHMC0Y_IlVr6MvPQ6UHgRQnvH8AixV1q.eRypBXKY9xjW9oV
 NmTnF8dR0JtYrSrBDDiu3gAAq.6cc54XUnOP9oY3M8pycrjmjUWto4.tE3IYZsz9kousIaaos8.o
 xPoJO6vv4pIsHPMNpPse5D8B0MS2_.tBQwdMQ5Au5WqmmcV9hQKojAMGpI1G8SWc8ddahXON4HSJ
 BF0BLaH3FVReclhOpYcxYDg2aD0wLJGBa0Dud34pc_bt5MlfjAHmuWzfFT1GoHpxoVQLIP7cg6bX
 ho13M9WiMC1SxSEKAVhB5JUWIiWsFS7JNlTFGoWa.exZuj4SK6dRPxvqLRUa9vBNAC4Uqvxql9pK
 jd4vK0ZgfTCsttTJFEHKttbnL0eK4ElERPGHqnelSDhoEoRDpenfAOTU7YOUeWek_CoenM6xJFsp
 W78Xxq60aSwSj3NtNMTotWPtaT73zLNYC33etjAOUpya7P23CrHtW2BsRMM1d98swrnLjWCWA.uN
 04D6Fq2ndaOhxUiL7TkPRu0HSRB2pA2Lw9rJfLM3_94iS59Y2iAEA7_zLwbRYjVvHu5_Ed23RJmx
 FEEQAMtHxnqLVabOobgs28RYOPx89o7QdUmuwLBQH0iLVy9yfry51rYddRMLTYUJ6mEI6W8a4efR
 Lb__EKfSxL0gyUYDC37VXP638UxhdiVQ7umMCDr2kGkLPFry_dVhcGXzqNzWWb893T6XRXDIcxTZ
 zjxj8Zk1UhSs1XKxBOqGoKY.RpvcH7p7VVz6YE9XOYDHXi0i8194oSUGzFIfrsVTdMGZg3fkhThq
 KPHgwumiT.A0a.52JMOiExy.kBAPanj6ro4J4gaoTSwvrcgufptrf5H7H6gk7sCYUlb0SLx7NsYI
 nlDjNsV56a.6Plx2D5cmZU6xn6irrlX5ZNN0JhQIG_NY8uds84rDSrY0igOZYmD5PFEeyS6C00vy
 EVFNjx7ojIC2WMy4ViyIRYaMi5E_30VtP_m_5j7jgitxtH9uhhiHG11C.xdkBP8jTt_Yg25n0XPd
 vePA7EFsZd6XhyYMW6HrnJLwShfi2AErZpkFdBZu3I2VYTGtFmNYQw3ipL9nxPhy4J3y2GwRGLmP
 nbaX4r.yFmmA2fuQgZNqhimSKhiYdXz7djpP39xQXhJon2tzE0Q--
X-Sonic-MF: <abdul.rahim@myyahoo.com>
X-Sonic-ID: c53e7182-f874-4911-8adf-185946011a4b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.sg3.yahoo.com with HTTP; Sun, 15 Sep 2024 23:53:52 +0000
Received: by hermes--production-sg3-fc85cddf6-lbhm5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 756f2e6de304e0def2adbfdccfdbe229;
          Sun, 15 Sep 2024 23:53:50 +0000 (UTC)
Date: Mon, 16 Sep 2024 05:23:44 +0530
From: Abdul Rahim <abdul.rahim@myyahoo.com>
To: perex@perex.cz, tiwai@suse.com, broonie@kernel.org, shuah@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/alsa: add silent flag to reduce noise
Message-ID: <lku6mdwwfhufyap2kjwxrzfoka4wfjaldq2xqver4ktnuuqd3t@wicnoorkz3wm>
References: <20240915234131.61962-2-abdul.rahim.ref@myyahoo.com>
 <20240915234131.61962-2-abdul.rahim@myyahoo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915234131.61962-2-abdul.rahim@myyahoo.com>
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On Mon, Sep 16, 2024 at 05:11:30AM GMT, Abdul Rahim wrote:
> When ALSA is not installed on the users system, the error:
> 
> "Package alsa was not found in the pkg-config search path.
> Perhaps you should add the directory containing `alsa.pc'
> to the PKG_CONFIG_PATH environment variable
> Package 'alsa', required by 'virtual:world', not found"

these errors are being printed by `pkg-config` and the last line is
irrelevant in our context
> 
> is printed 3 times, which generates unnecessary noise.
> Hence, Remove unnecessary noise using `--silence-errors` on LDLIBS
> assignment, so the message is printed only once.

or should we return error if user does'nt have alsa and move to the next
test?
> 
> Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
> ---
>  tools/testing/selftests/alsa/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
> index 25be68025290..cd022fc869fb 100644
> --- a/tools/testing/selftests/alsa/Makefile
> +++ b/tools/testing/selftests/alsa/Makefile
> @@ -2,7 +2,7 @@
>  #
>  
>  CFLAGS += $(shell pkg-config --cflags alsa) $(KHDR_INCLUDES)
> -LDLIBS += $(shell pkg-config --libs alsa)
> +LDLIBS += $(shell pkg-config --silence-errors --libs alsa)
>  ifeq ($(LDLIBS),)
>  LDLIBS += -lasound
>  endif
> -- 
> 2.46.0
> 

