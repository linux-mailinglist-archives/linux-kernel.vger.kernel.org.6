Return-Path: <linux-kernel+bounces-312009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A229690DD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 03:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5020B222FC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 01:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669631CC8A0;
	Tue,  3 Sep 2024 01:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUOWCqcR"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0AF35894
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 01:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725326464; cv=none; b=G63zpunB7EyjK5hov3u7Ujct1+Fkb2T72Er3wmy2LDqQtV6aoiNUE3xAAOwDiFpYm5FofDUIg/dGNEIvdiju6kyVzIjdA8fJGJmivSyv7p4lYJLkWg5jaoFCp/ZKaRUW9f+3TTGQFI22djEDzarJ/thVMcUMA5LSrjsDrZrpx1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725326464; c=relaxed/simple;
	bh=kki4VhT+Wm5EWEDklEowt/1z2bQ5VEvZMOKVzeJ7UG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtUoDpz8C6b3eN+aerGn+90xFEbCCJo4HOuvLghgJt4wi9htd3bqYEMBPGvv4qH++OerZYxja5nGkqOGmEMouqlet7tHr36DHzXGU93dBMvAVXXVlWIek07uQOQm1npgI9dpDOBlF4gOLuePrJtF9lLySSmdTS+INDqQOcAMbU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUOWCqcR; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7176645e51bso811976b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 18:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725326463; x=1725931263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmswcnWkPjx3woTAru4QxpFURfDAiH60zG4F5Jk5vUc=;
        b=WUOWCqcRYKPr12gRo+LhQ8K/ZSB2HIcMlKcHsJyQleOGZOI8tcSdVoO1PIY31lfajx
         nTfa1iClrJCOzM24GQ4lKNSyuEK2ojx2n5Z1xhCFGBOcaR9J7sMIGFLq8RI8iUOj09Un
         akMfXwpoD7MUDqZds8AO45wO7n88ZzOWPvvXD8jqMc3LDpJrxDjW+NGnK1MW7sX9SEla
         Z2hef77/AyEwZbDXxqmAbA/nWRAt8W5hKgMGJyPgxm7XMNdj1wzXfedCWgccPipU+MmX
         ANo4xfcEEl8ZslotYi/hrmoQVN35Z8BadbxvtbkdtnuDwScLQ4PBRt1sPkSohfJk5yEz
         OdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725326463; x=1725931263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmswcnWkPjx3woTAru4QxpFURfDAiH60zG4F5Jk5vUc=;
        b=T2rhCuQ4OGl1nls1q4tH02CFYnEcdmBy8vvwp2Yf8uO+aC+D0RNTAG6Vq+j2jzV/Yd
         hrddAcBCek8ZJZ3yYoiWILx88FflkvaQT+8tj4f/uYAGhOXr7YxX4vFwKJ1QPKHZI2f2
         I2X3o9XfIUlND+OuXzJbivf8kSjM8+3i8oJqMOTzESaK7XofM0pLELMNkocHn764Ftaa
         CjojDoCANF5Y0Lm+y/TsbXqg+EitM11wsAsgbEE0L3NxQGZ1VmhXbashpOFmroyT5XdG
         EumAPU0+PgZgu/rz9HUQatNoaqnicyeLEs/nP2DgX6Pn03fG/ejDVjvMmfBTAh2sjaQf
         /b8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7C34ZcTNcm9LtOf5LYYdKvQ3i1nyqNBDGJ+ykK7ueMOgcVU+1y0so8eaOvCJtA+GpNQUXmWBSiN9i4oU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIthNdtcK54rgpKGYufZ4QukWKuBYCAN/fzw42Mp6QdtWoXsU3
	K64lu1riF9XjVOHDQI4O5mKYh6m51QYSfdZXbPK8LY4vZiymOMx7HXDOx5pDBBlbMtKDM6OkKLS
	MoepfpKsywj4wmMCr4sGS0qBVNEY=
X-Google-Smtp-Source: AGHT+IFSs3iK2zQclwWKK48pQrtL6JimRbmmzHuCgm5qflbmnd1hOBb4zrrUWvfxpyItM9/pBEmJoDk2swgc+V7rvdA=
X-Received: by 2002:a05:6a20:d50c:b0:1ce:e725:1709 with SMTP id
 adf61e73a8af0-1cee725184emr6123399637.48.1725326462504; Mon, 02 Sep 2024
 18:21:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830032442.226031-1-aford173@gmail.com> <20240830032442.226031-3-aford173@gmail.com>
 <ZtFfBs4HEShmJKsi@atmark-techno.com> <CAHCN7xJL-aS+kFp2YwtSSUUMoTBqZCsXb0qvCpYQGpJVM_qJYg@mail.gmail.com>
 <ZtZcit7HVzzedgdk@atmark-techno.com>
In-Reply-To: <ZtZcit7HVzzedgdk@atmark-techno.com>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 2 Sep 2024 20:20:50 -0500
Message-ID: <CAHCN7xLVSq9gh9KbKbFBcZ7HT5vgv4JHdn3QTXFf5B9t86Wp_g@mail.gmail.com>
Subject: Re: [RFC V3 3/3] phy: freescale: fsl-samsung-hdmi: Support dynamic integer
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: linux-phy@lists.infradead.org, linux-imx@nxp.com, festevam@gmail.com, 
	frieder.schrempf@kontron.de, aford@beaconembedded.com, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Marco Felsch <m.felsch@pengutronix.de>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org, 
	Makoto Sato <makoto.sato@atmark-techno.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 7:47=E2=80=AFPM Dominique Martinet
<dominique.martinet@atmark-techno.com> wrote:
>
> Adam Ford wrote on Mon, Sep 02, 2024 at 04:20:11PM -0500:
> > > -       const struct phy_config *cur_cfg;
> > > +       struct phy_config cur_cfg;
> >
> > Wouldn't converting this from a pointer require me to do a memcpy
> > later?  It seems like that's more work than just pointing it to an
> > address.
> >
> > > -       phy->cur_cfg =3D &phy_pll_cfg[i];
> > > +       phy->cur_cfg =3D phy_pll_cfg[i];
> >
> > I think this is would have to be a memcpy instead of just an equal
> > statement since phy->cur_cfg  would no longer be a pointer.
>
> C allows copying structs like this, it's fine to write it as just an
> equal.
> It's not 100% equivalent, iiuc simple assignment is undefined behaviour
> if the elements aren't aligned but memcpy will work even in that case,
> but for us this is not a proble mand the generated code should be
> identical... Also note I'm only suggesting that because the struct is
> tiny (1*u32+7*u8 is less than two u64), but this code isn't meant to run
> very often anyway so we should prioritize readability -- if you think
> it's harder to understand than an extra pointer somewhere I have no
> strong opinion; as said in the previous mail if parallel uses are
> possible it'd be better kept on the stack anyway...

Dominique,

Unless someone pushes back, I think keeping it a pointer is more
consistent with what we did before, and it's more in my style of
coding.

I have two more patches in the series.
*  One updates the round and set functions to compare the closest
values between the fractional divider and the integer divider and uses
the option with the smallest difference between the achievable value
and the desired rate if the actual value is not achievable.

* The second removes the integer divider values from the LUT since
having it there just takes up extra space and makes the LUT search
longer.

I'll send it as V4 with a cover letter describing everything I have
done and the rationale behind it without the RFC designation.

For what it's worth, adding the integer calculator added 4 entries to
my modetest list, and changing the hdmi-tx to support a clock rante of
+/- 5% added another 11 possible entries.  I have not tested them all
yet.
I likely won't do a patch for the HDMI-TX, but if you want to send a
patch increasing the tolerance, I'll likely test it as I have time.

adam

>
> --
> Dominique
>
>

