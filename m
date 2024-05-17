Return-Path: <linux-kernel+bounces-182488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D349E8C8BBD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853CD1F27BA6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1E1141999;
	Fri, 17 May 2024 17:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azC3BY/A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5FD13DDCD;
	Fri, 17 May 2024 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967869; cv=none; b=WCADOXv7sQFxzIImRGbkwb3YfkT+EyGRLl9FeBsHwiSohPTC6kAVxCGUKO6L5zlwJE+PfVDNP9/ZOConlh8YaaadN4Q5jT99jguenMLpFe6y0e4FCg123gLav4OPqVbOusTEQG0UmeP0kBbcGFHV4T80Ut/IMDPPcAHJAoN6ZJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967869; c=relaxed/simple;
	bh=Nm+T58qBk59wXpsTupEzyucDfvFB86ewSPCmThFAah8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cmdAFNiTDxKynyzA4mYpvLJOKHWDhXpLwXSJijLJ/Kum5rJKeL0qGDLmCuTEAZMrx57edJsqmaFNkc7+CJoisy/cvFoA8ekt44I5qBRrOtKEg0evZOI4WniKHn5C0YTyHPiackOgsgtLIGhoQ0FBZCOzITfrxaow+t+gRBrtluw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azC3BY/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFECC2BD10;
	Fri, 17 May 2024 17:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715967869;
	bh=Nm+T58qBk59wXpsTupEzyucDfvFB86ewSPCmThFAah8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=azC3BY/ASdaD7ZoBeeOgbrcgSvb3Rv0u7mwIQCIdoWds8KpPU2CuJYW7tjwjBnNcR
	 +fKze3Ck8JVYLPTffyd4qAN3/qN/UKl+O26D8Bd5fXuTwvZCfpxrRnvKaex2VYhPTb
	 F7DAbRTBQmKzD3KOwrFuNbHUHV7/bQDEHiNpV/VKsChMEv3zKHSLDIMzv0AoqTpIus
	 Sfun2vIremc5OU92byD4KTGZeQQmMdq7tkw53207gvxPOq3DfGSKsA9/81p0eUZ6Cn
	 VNsv1U4rs24nhjE/uyEG+ECcSjdu72WfuLrUJzkK/Hgj3HUBOfIiB0ofURNhkLHtyf
	 gnRQKYvetcyNw==
Date: Fri, 17 May 2024 12:44:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: yskelg@gmail.com, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Austin Kim <austindh.kim@gmail.com>, shjy180909@gmail.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] line6: add midibuf init failure handling in
 line6_init_midi()
Message-ID: <20240517174426.GA2285947@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734qg260i.wl-tiwai@suse.de>

On Fri, May 17, 2024 at 10:32:13AM +0200, Takashi Iwai wrote:
> On Thu, 16 May 2024 19:47:38 +0200,
> yskelg@gmail.com wrote:
> > 
> > From: Yunseong Kim <yskelg@gmail.com>
> > 
> > This patch fixes potential memory allocation failures in the
> > line6_midibuf_init(). If either midibuf_in, midibuf_out allocation
> > line6_midibuf_init call failed, the allocated memory for line6midi
> > might have been leaked.
> > 
> > This patch introduces an error handling label and uses goto to jump there
> > in case of allocation failures. A kfree call is added to release any
> > partially allocated memory before returning the error code.
> > 
> > Signed-off-by: Yunseong Kim <yskelg@gmail.com>
> 
> The allocated object is already freed by snd_line6_midi_free() that is
> called via rawmidi private_free at its destruction.  So your change
> would lead to a double-free.

I stand corrected, sorry that I missed that!

That said, it seems unreasonably hard to verify this path to
snd_line6_midi_free().

Sorry for misleading you, Yunseong.

> > ---
> >  sound/usb/line6/midi.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/sound/usb/line6/midi.c b/sound/usb/line6/midi.c
> > index 0838632c788e..abcf58f46673 100644
> > --- a/sound/usb/line6/midi.c
> > +++ b/sound/usb/line6/midi.c
> > @@ -283,13 +283,18 @@ int line6_init_midi(struct usb_line6 *line6)
> >  
> >  	err = line6_midibuf_init(&line6midi->midibuf_in, MIDI_BUFFER_SIZE, 0);
> >  	if (err < 0)
> > -		return err;
> > +		goto error;
> >  
> >  	err = line6_midibuf_init(&line6midi->midibuf_out, MIDI_BUFFER_SIZE, 1);
> >  	if (err < 0)
> > -		return err;
> > +		goto error;
> >  
> >  	line6->line6midi = line6midi;
> >  	return 0;
> > +
> > +error:
> > +	kfree(line6midi);
> > +	return err;
> > +
> >  }
> >  EXPORT_SYMBOL_GPL(line6_init_midi);
> > -- 
> > 2.34.1
> > 

