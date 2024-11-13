Return-Path: <linux-kernel+bounces-408018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B539C78E6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD19E284C0B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78F11422D4;
	Wed, 13 Nov 2024 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNd5COxU"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CBD158D93
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731515392; cv=none; b=MWzVtMIwQLYvFP9t+ima9996Q6hJWpfCvO+61JtL3xw2bugsPnUG0qehQ3YWpdLXH55Y2tc1EtQr+MznVS+d8xWjBdQ/Y2HU6na/b4JkOj1MfCB9dou3yUK/mugTvAdzm1+vHk7X8S1JnNzjFtXptzuZ8gZy9/2UDGbkSvXrpQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731515392; c=relaxed/simple;
	bh=scwSpwG10WI+53wv0alXx3oFBiPwcvUwqxFHYt3iczA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXTfw8kBD9LTo0P8WVMbJ3/tO1gM1/bVsk2c7ER3t3LOYwhNFxWKDJWJ6kWPbyXG5l0CgK7QEvYx6XdRIUWqC1cxh+Q3L5aJwwoXqyguqLRa5vFjONg4DqxvdEvwmk8pELwZhvCLOxF/TLXqV4395aHHuYAnM08mXACBhu0w4zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNd5COxU; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso97597231fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731515388; x=1732120188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hfqt1W/nidKagUh65+dskZ0HFRd7l9QPJ+8QdYuAArY=;
        b=bNd5COxUeSPkP344Bs0FhBKCLofZJnjvjYU8xg3SADXmIpfFkNUFMoJTMIKXGPmjfc
         pTrdDJ2cxqap6G9KCiOqrrwSgWgrH35Qyr3hgWM/f0y4S4XdaxNPpVpX0l0POXgiDZ+x
         wKBbm5gfefYp/oavm8eX/fUjttbn239IDFHQwvE2U9TTCDnhQsZ/OVnzRsaQrfZNM4HE
         NVvH5rIgSIVyJQ/VTHvCKO7G7aUxpmfqC+MY1JWzHf38l9n1Gmk99OsTNMWzDXskq8Jx
         bxhe9Wd92vcAJY3kPedMVR+DZM1uR5wMXyFgQ2hFTCHk1/QRWZmqjcDz/qsP6akYwgAl
         15eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731515388; x=1732120188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hfqt1W/nidKagUh65+dskZ0HFRd7l9QPJ+8QdYuAArY=;
        b=VhdF8VW9hMvGC4wtFGjAxXuQQfNB9KxnVt9OsdnY2B+a5OtggEtzty/hGErOkLMf8/
         VS0LzAXb7inlOOHBmBzhsgpEgvQWmqQgJzBP+zfS2ckJWUxID39RfTN970ANXkTOUG3U
         0WIY/4XKx7wSsvIhJQXox6GET11byQ2fSThXSkk8GwsfhsR5JEoFWUP5SS9hyOvxsXP5
         NHxVfQYwW9Wp0nxer2254eQJ/Qoh6uWZ3GH7sMdiWhh5H+9FMFNE/HrPQZzIJozh55RE
         XJlmMBwKWtw7m0tJfTrGR909WZFvX6/vzOCj4nxNixPSIdAmlsAn24MpBRBR0Gy2NHI/
         J0jg==
X-Forwarded-Encrypted: i=1; AJvYcCUwhLE2m8nxojksvE1VLjSuFaDugTQW+qtfT8wuHKqLHU1hBI1LrqWHLpMli2XkP0WKdAbxTKnr1QKN180=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgNLtiJKamLDrOFnSiCFdjviJ0BJUJkTkgv17pTouAqVVRkc8C
	/y4IBFLK+OVwOpIhnKZQ6jAVOHrW1jY/3xjH9CQZZ+JyU04IRShzceyCE/FhKixwV+NPCYPuhS0
	ngcIkdJ2IqTneD5pOQEsLOk9N2xY=
X-Google-Smtp-Source: AGHT+IG0K63G7clYWGyf+2qx8AAKKzktSdOglK6Euy7htYO5/bcDg5LOcacKllOU0lEbf8JHVeAw7kWTy2AHh5ewo9o=
X-Received: by 2002:a2e:9a0a:0:b0:2fb:5bd:8ff2 with SMTP id
 38308e7fff4ca-2ff201ba9d3mr157532151fa.16.1731515387988; Wed, 13 Nov 2024
 08:29:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027075108.14273-1-vamsikrishna.brahmajosyula@gmail.com>
 <20241027075108.14273-2-vamsikrishna.brahmajosyula@gmail.com>
 <87cyjkpcik.fsf@intel.com> <Zx-h-qCeU0e9B-eK@intel.com>
In-Reply-To: <Zx-h-qCeU0e9B-eK@intel.com>
From: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>
Date: Wed, 13 Nov 2024 21:59:36 +0530
Message-ID: <CAJvTgAj=fe4-JuBRUEHuw9jUm-SRvuxsfuSpkBfRpdU2i+rXmw@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/edid: convert drm_parse_hdmi_vsdb_video to use
 struct cea_db *
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	"Syrjala, Ville" <ville.syrjala@intel.com>, skhan@linuxfoundation.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback.

On Mon, Oct 28, 2024 at 8:09=E2=80=AFPM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Mon, Oct 28, 2024 at 03:45:07PM +0200, Jani Nikula wrote:
> > On Sun, 27 Oct 2024, Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajo=
syula@gmail.com> wrote:
> > > @@ -6320,19 +6321,20 @@ static void drm_parse_hdmi_deep_color_info(st=
ruct drm_connector *connector,
> > >
> > >  /* HDMI Vendor-Specific Data Block (HDMI VSDB, H14b-VSDB) */
> > >  static void
> > > -drm_parse_hdmi_vsdb_video(struct drm_connector *connector, const u8 =
*db)
> > > +drm_parse_hdmi_vsdb_video(struct drm_connector *connector, const str=
uct cea_db *db)
> > >  {
> > >     struct drm_display_info *info =3D &connector->display_info;
> > >     u8 len =3D cea_db_payload_len(db);
> > > +   const u8 *data =3D cea_db_data(db);
> > >
> > >     info->is_hdmi =3D true;
> > >
> > > -   info->source_physical_address =3D (db[4] << 8) | db[5];
> > > +   info->source_physical_address =3D (data[3] << 8) | data[4];
> > >
> > >     if (len >=3D 6)
> > > -           info->dvi_dual =3D db[6] & 1;
> > > +           info->dvi_dual =3D data[5] & 1;
> >
> > Just commenting on one hunk, because it's a good example of the whole
> > series I think.
> >
> > The above is nice, because it improves the offset vs. length
> > comparisons. Many of the old checks like above look like off-by-ones,
> > when indexing from the beginning of the data block, not from the
> > beginning of payload, and cea_db_payload_len() excludes the first byte.
> >
> > The main problem is that the specs are written with indexing from the
> > beginning of the data block. For example, HDMI 1.4 table 8-16 defining
> > the HDMI VSDB says source physical address is at byte offsets 4 and 5,
> > and dvi dual flag at byte offset 6. That will no longer be the case in
> > code. It gets tricky to review when you have to keep adjusting the
> > offsets in your head. (I don't remember if there are specs that specify
> > the offsets starting from the "actual" payload after all the meta stuff
> > has been removed.)
>
> IIRC there was some off-by-one indexing difference between
> some of the specs. But I don't remember which ones use what.
>
> >
> > Now, if we accept having to do that mental acrobatics, why stop there?
> > You also have extended tags (first payload byte is the tag), as well as
> > vendor tags (first three payload bytes are the OUI). It begs the
> > question whether there should be higher level data and length helpers
> > that identify and remove the tags (including extended tags and OUI
> > stuff). For example, the actual data for HDMI VSDB starts at payload
> > offset 3, as the first three bytes are the HDMI OUI.
> >
> > What to do? Ville, thoughts?
>
> So just different *_{data,len}() for the different indexing variants
> (as defined by the relevant spec)? That seems like a reasonable
> apporach as then the len vs. index checks might actually make sense.
>
Please let me know if the below snippet matches the feedback.

const u8 *vsdb_data =3D cea_db_to_vsdb_data(db); // skips indexes for HDMI =
OUI
...
info->source_physical_address =3D (vsdb_data[0] << 8) | vsdb_data[1];
...
info->dvi_dual =3D vsdb_data[2] & 1;
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel

Thanks,
Vamsi

