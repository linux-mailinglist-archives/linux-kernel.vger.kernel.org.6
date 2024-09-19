Return-Path: <linux-kernel+bounces-333844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA38997CED9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 23:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD6F283AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 21:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B75514A4D2;
	Thu, 19 Sep 2024 21:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b="LK5SfUcG"
Received: from sonic308-20.consmr.mail.sg3.yahoo.com (sonic308-20.consmr.mail.sg3.yahoo.com [106.10.241.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0D61CD02
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.241.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726782563; cv=none; b=WQVwFcORgkk2u+zlBd/wC48y22h/quvC0+vGFfL7PVn8sHw9DD1R3jX1er5ZGfy99r/VgfX1JBP1lgTki88n9RKuQCZa3bwkPHqVZlVFUkzVNZ/ApKVIZSE2Mp1XkvnAHDhf8uIXWqIHxt29t4cZNoljFK74uWTvZUWiwGjk7E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726782563; c=relaxed/simple;
	bh=dLMZ/MD66XgecPLDT0TDs8dGF7M0ZhqJXRVXqQX1SgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6MYe45j7+SUDHP1XcsGYu4Txntvl+y2GY9T52674SRoVis2ADPueHYgv6dN/RqbHB0cAyiBPVUYOqqwFmIeFHLH32FJLviRyk8SOZu98T9RycjgUA/2mxDwVb6Xvd4oigye+vRc+UW+ib4GK5ePLvko3KibWC8kBuRl+JulgPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com; spf=pass smtp.mailfrom=myyahoo.com; dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b=LK5SfUcG; arc=none smtp.client-ip=106.10.241.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=myyahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myyahoo.com; s=s2048; t=1726782553; bh=4qrzhRP63aosEfNPmvuFGJY4VPG1I7L924YfvcITJEY=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject:Reply-To; b=LK5SfUcGoaXy8Oclpj5ivxuXohx7LvxID1ml66CL1ysQFmt+//oSmiY/+PQ92PwUMr+CYiJgIfJMs+XWCKFeZolmWx/q2AJeitoCfg5KQz9aTZJT7bexVQ3qpctKKLKjI+i+Oaw8y+/YRJ0vPj8PfkPl0NjBaoQmMYpJsDiV6Zg09N7m1miGW8b9BNtdKsr/cg0fiqtYuHvI26ArBJ9k6JeENnklOs9EcuTkO5Gs1FNxDzOlLYT7SefPr07wN8zrVgjr/DYTfkK0jQU+Mu518v0OvEyq9YdjGFbNsvUJamCn456BOnT1kPNxrY0B2m0oZkFMGLK88BK1yfY/BqzfFw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726782553; bh=twEYY+W0+J26a0ph/GhdHkRbw6Iw1aZ38UGlhouHSr0=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=VNhqYsZSkAODXekNlqdnntjAkTvDbE9jmCXZKqtQGFG0E/FHj9AZtY+Y5zHGzNBw1OHkCpmZ618zGjTw7YQyouCcA3AbLKeTOILHUcBk20uXgjs+DP+VYFLWvDBmgTxH2WTc7+6TbGpgCFZHGmoUjO01uFqp/B2FmPG30CzlG9Jk0NR6kJBv2YhsjYIWSTcNPQcbcy6NRjQ+aVU4mixIB48Xph0gl7N3RJIYZsT4W9W8yggDboQXOuWv/dnt+hNCyfkyt7G9IMmExhZeTGHk/p0iYwAmSGbCuZ4ik6LIGGwsU4LiJ1kgg5pCtgnOgUjISEMQSGcqfheXHOSkrFel5w==
X-YMail-OSG: jB2Y5CoVM1nbQs3nWZM9cLlt0AbnPQ7_SIKTnInZ9SG1q6kdkEDSWezLabhq.kG
 zCK4NNgdn8dlw701i8bgYNnKuIzOXeAYXwFO65lUVFAw1zGCeXYK58VYNalyF8bqNPtf_ctyrJ1l
 4jY3m4ZxmRPisTFwEhnOc4Cl0JCI0VgY1rbXDoD1WpFB1Q.giuQuqfwVLiHRT68wr6r1hwsxviOi
 edN5rj0nqSRgn7j1HifJIqwOJPoX4iQgejMpfvcYErV9G0h7o0JsAqZFmOzpkv2Uzj2YPEqKuKpP
 quUR.4IqRCQQf4DbvqAOP0daDBWUxhUe.2DLDNGh0fzz0Ss.5sBjJj8iwWgD66uDYTiWyR9ANnup
 M1Go8qKYcmXaL.S3O9CurjxgW0tdEujMC.gQfSTP3LNefyMy2a9vrf0dMMzQWN2WPfJJkDussqlL
 .JFnjJLoosLxPAcCApXqIVEtha56fv1cfQfvjnh2nTg1jj59TaOsmBGkupq7ViR3tWj72MURgGvZ
 fKcA.Fzexkq4CQC_iRC0_5UC2oZo0RlUXXhOpCCqSlE_KpKcE819ch8ycNytcdSuqXlsl.Waatcu
 Wt4xXfMcqEvR9lhFKs.VF6YxM9HSaj3Il1K8S6uP_btCI0P1ZqYlGcUU4RXVw5cuc6Jn6aMUpXqx
 lLurOuZLjzSv1I8bNebqL9xohd.oQejy1x42cltZV8pfyPNixdZyPhw2jVDgzOVn1iUObN8OCJZs
 o6vDp5GpUPO_NskN.S1hSuN8ujZRe7MFYSibGqYvoGOCBSfj5HYreNbU78TNEA2yFTWdUl5pEVyy
 DUM6CYS7yt32YtN92sEA1zoGiYBSeFV1..FYR3O0SnSUiQRdckUzp09MqrmDMHj9ZSpTvNBqP0SQ
 o4BJp_GvA33_tSctSFK2uCuv9ShPMU6LwNJQbIRBBMidkRFo7r4cZz69czwrkgyy9ePALeV9yoaV
 N7yQgFhlO_QDEDGU5vYBR6rkqz97QTO2N4iW1sMRWzoe0t26rTiYxYhN3s6sw2kpNLAuzp59Oxps
 ppzBDsrWclAcFKMnzhRuFImuuvd6YqHdkD31mfQY99try4qR6FzJY5Zz.mZT3y_mVmM2Dz8ZGL5k
 faVmkVuWnoiGkWPC20HJ0BmCj2oDqQUJdBO.FABqVHz2gO4uEbCdimFV7iefgixON18mjvU171bY
 JUSlCBs20tK0a6laYIZPq8Hth_BiTF7zOW3s_dM8JT3NPshfB4eDLhDS_2i5zelX.3_p9cyGlz.z
 zDxu2jSfYMTKRFvYQ7DPyNHIawaoSRgle2EWEeimbqdtQSIgg4ccW_sEYs.ZvsPOflkKhhBT4lG.
 VY5oJByeNbOQMQiWvLe6Yg00G8QKePWFa75Uj80Fi.ucUuNT4nGbOCzGn4i1zbJ.rcBHHogFaaJk
 pSN86eRoy5sLxsuzfpJG_um18g5Tzi4yT_mQxVsPgls41dJwsQrfr_hscf2DYue6E7gQKtAEc.sz
 dmUeYDwpJpbOyPh2.skSDu7NxRmPR8Izf8fHewk4BsxlfVrP8zfJNPmu951cib9_yuriaTODHjZn
 XBttDl3QGqK8kmXqYlDkpFXweJhPs1iZcLWFn7ED_pQ1019wmNomH0i1Yuapxp1ps2ixF44SmeQF
 9cKfsLvZfswwmU9M8QyoH1dqDUS.UwfyBIFwcU6TFqbzhLudALdsNS9d35kyiqQX7TTeMFbBhETF
 UuN.D4G71jKEsYxj5mVhfpJ_uYEtcCbNq8YolACLaFOKHCqmLAbAzLwGnQYHITeWYL15FTq6Vqk0
 lzS68vGp22EufjWX.oMGbl1ZWXoZ2hLrePp73VxU0fVY5Y7OORrfbUC5NXQMOgH3zooCuQpCueqJ
 hAi4PaBvwvN4xnPHbCx.QbsZqS2ukaZ8_J.g8pmLwioVToVT7wnpNSEi5.2YXefVP9SJPaYtO4.b
 xQgFH0XQQjYySGEv4QFYmx9QmVY2xM8ZUl3fc0zcHOVtwZSnJCwwX2YaFyRQOKpRdFJtCDOrHdnf
 EAKbZrZTAvPz_o1nLCeogm9nJRhpLmF7DZ5HWzOm5E_8FBlxEDVEBm54HMMEm3afZ8R87NW3prtb
 lHe50SgFrNSU2tAhY52xmOK1ZhdPgjmGHb94QpKoOs8zZ6sHHY3qTPISt8ArXpLCCJsELqFf1JZn
 KLUDhs7jMHw9iXhrH13wX_3FSij0iSJOjPTPN60eyA5D15zh0QvPwWVfla6IwQZRDgpVDlFZVlKS
 A_e2VZm_F_9dS_ieIsIvE_elCNHfn3cvrKXO1PydOehqUKAw-
X-Sonic-MF: <abdul.rahim@myyahoo.com>
X-Sonic-ID: 2f67f458-6d62-4e18-9dbc-49a9b0528e34
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.sg3.yahoo.com with HTTP; Thu, 19 Sep 2024 21:49:13 +0000
Received: by hermes--production-sg3-fc85cddf6-fmhgk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e0dcafaf33aa010aecafe1988b6dcbd2;
          Thu, 19 Sep 2024 21:49:12 +0000 (UTC)
Date: Fri, 20 Sep 2024 03:19:08 +0530
From: Abdul Rahim <abdul.rahim@myyahoo.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: perex@perex.cz, tiwai@suse.com, broonie@kernel.org, shuah@kernel.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/alsa: add silent flag to reduce noise
Message-ID: <vzrosmbs5x5mmnxwubwljjqxo4m4eih35z26cudshpbr3uue7j@k3v65fkr24rz>
References: <20240915234131.61962-2-abdul.rahim.ref@myyahoo.com>
 <20240915234131.61962-2-abdul.rahim@myyahoo.com>
 <7caf7242-1ca4-462a-b3d0-627258df3f1b@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7caf7242-1ca4-462a-b3d0-627258df3f1b@linuxfoundation.org>
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On Thu, Sep 19, 2024 at 09:40:34AM GMT, Shuah Khan wrote:
> On 9/15/24 17:41, Abdul Rahim wrote:
> > When ALSA is not installed on the users system, the error:
> > 
> > "Package alsa was not found in the pkg-config search path.
> > Perhaps you should add the directory containing `alsa.pc'
> > to the PKG_CONFIG_PATH environment variable
> > Package 'alsa', required by 'virtual:world', not found"
> > 
> 
> extra line?
> 
> > is printed 3 times, which generates unnecessary noise.
> > Hence, Remove unnecessary noise using `--silence-errors` on LDLIBS
> > assignment, so the message is printed only once.
> 
> I would say this message is alerting the user that the package is missing.
> Why would you want to delete it?
> 
> > 
> > Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
> > ---
> >   tools/testing/selftests/alsa/Makefile | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
> > index 25be68025290..cd022fc869fb 100644
> > --- a/tools/testing/selftests/alsa/Makefile
> > +++ b/tools/testing/selftests/alsa/Makefile
> > @@ -2,7 +2,7 @@
> >   #
> >   CFLAGS += $(shell pkg-config --cflags alsa) $(KHDR_INCLUDES)
> > -LDLIBS += $(shell pkg-config --libs alsa)
> > +LDLIBS += $(shell pkg-config --silence-errors --libs alsa)
> >   ifeq ($(LDLIBS),)
> >   LDLIBS += -lasound
> >   endif
> 
> 
> thanks,
> -- Shuah
> 

This can also be handled like this:
---
CHECK := $(shell pkg-config --exists alsa; echo $?)
ifneq ($(CHECK),0)
$(error Package alsa not found! Add directory containing alsa.pc in PKG_CONFIG_PATH)
endif
---

Benefits:
	- save computation, by not attempting compilation that is sure to fail
	- reduce clutter in output;

Regards,
Abdul

