Return-Path: <linux-kernel+bounces-374490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D359A6B0E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7FCF1F22674
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E4E1F706A;
	Mon, 21 Oct 2024 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxJOxD0P"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9611A1DC04C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518733; cv=none; b=AR3UX7RRPzn3UmLUGob09bmFs2lF9EpY/3mGvtFjQIqRitmMqd6Srj/XaZhHd++rjLMy8yVjuj0GlvKbO6hmXT3brGYmstnzyU2ty3OHtXDFRovZCDE6nWwwBWJbH+3aCL7JRlNUDvvLTrsNh8hBVOQJx6WyPOttjLb6OB+tkYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518733; c=relaxed/simple;
	bh=bYdE9alDoyS09v4GZeNCMkIB37MfhXp8vFJTOKqtrdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pxHOWzNvK5yH2qXhIHBLLmX/YVO6gXDqrA6RRg2uCY6s7yWsxT3ipSMm1unGb1+KqU9yqNme46YiBrL5a75D/6l8U+ZZlbCQVTg0OWBevgqbvwSP+c92RFGD/cImlMPpJ6uSa7SbRmrzi0AlKX2ilUPBXnNadXY+dei7TTityi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxJOxD0P; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9932aa108cso660854966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729518730; x=1730123530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGeL/CMLQop9L2aOH26yIjOa9CjW+8emQ3skOBpUpHQ=;
        b=mxJOxD0P6DFG6giKxrTkMek/GhVtFlXbKn7ydeHwaLHr8eFBpObTAGz353bQJhD71v
         fpetSgFuUFSfsk/rYhwho187TZWWBEicK8FHl3l6lDmgHB6NPfZ26C4hulIAdUpPHGYN
         9Bj7FHEpTKVrxZzbdcYD9vswUjXG3w7jzQ6DDOY2Gie8ELvRMs9WPC14dvtPlTQH1hfn
         Q263ht11wDFtaWe7g0OXHZ54wYmUEy3hRMCDLBjf9OBIu1NifmIA8AzxgePVpYFG+t3I
         c/38IQdpO/gpY3M3judGIR39afbCwqqZh/DAKvuYH6SKJhO8p6U99jJNEod5FyltvDZD
         N2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729518730; x=1730123530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGeL/CMLQop9L2aOH26yIjOa9CjW+8emQ3skOBpUpHQ=;
        b=KifgDhxuGEYj4cvTtF/XmzRmomqzt2l6YVIx6F1Fa8xurM72sH25HGwVeZk1eFIdJ1
         SOOWEzYOQXD20QV0zSEVrAKtvONBtGqYN4zXWu7aebU32IoizGbHNGx+95GBynrkYLLA
         MTKiNaWV7b9Hl+MxY3Le3YhyTFY3Kymb5xfz3axf8sqA5Dpbi1IcPt5mXqFEhH2LCa6e
         G+r1e50ZQmeL+JmZoS5jQ1gugb5QLX7G5AU/ubyTihS4eUhOy3IAoW0G9AhQVglWikIq
         PwRYyQHz/CxZ038FA/iADcLQIyJ8SgRaOCaPRRRmexWJIkRpNRIpsqv0kjs2HL/DOJxq
         S5pg==
X-Forwarded-Encrypted: i=1; AJvYcCVNjbUCSzuOWqPbn4VCt/+tjjjRwiwlKQgRscf5zK2wtpZZwOMVdjM7H2QJ8lNFUTKsTaI/db13RfQHXuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGI2Fo+Kv+C8A1dj1Dz1m+XeeFgrKYWwV1YkA7jTXEgqEC3Rsf
	wgoRGhFH3e6LxJlNCQGCcEegL9ZDO1HqaNxDn1tmsC+8iAB3p81xLqqd/QOdfVPHXUAztsN+jX1
	IZyXSZVEtgoxKqzsCO/UG38oyscQ=
X-Google-Smtp-Source: AGHT+IG8YhpQsAqwyZSP89Tw+0wRBO5Bgw/ljOxfS7/Pfo8btVfvOSsdL+NHtFF+Lom91E2wgUPS0YgSu2U2n86kc0k=
X-Received: by 2002:a17:907:8f08:b0:a9a:6bc2:c0a3 with SMTP id
 a640c23a62f3a-a9a6bc2c0ecmr789146166b.7.1729518729497; Mon, 21 Oct 2024
 06:52:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011152929.10145-1-vamsikrishna.brahmajosyula@gmail.com> <87jze1y3mb.fsf@intel.com>
In-Reply-To: <87jze1y3mb.fsf@intel.com>
From: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>
Date: Mon, 21 Oct 2024 19:21:58 +0530
Message-ID: <CAJvTgAjb1h=1vn3MVNbTu=qrxf2zaG1RgF4jTM3uobTfpd9YRw@mail.gmail.com>
Subject: Re: [PATCH] drm/edid: transition to passing struct cea_db * to cae_db_payload_len
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, skhan@linuxfoundation.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 7:12=E2=80=AFPM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Fri, 11 Oct 2024, Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosy=
ula@gmail.com> wrote:
> > Address the FIXME in cea_db_payload_len
> >       Transition to passing struct cea_db * everywhere
>
> You've misunderstood the comment. The point is to pass struct cea_db *
> around, not to stick to u8 * and drop calls to cea_db_payload_len().
>
Thank you for the response.
Would below be an acceptable change for the FIXME?
1. Use a macro to extract length from  (db->tag_length & 0x1f)
2. Pass struct cea_db * to all individual parsers
3. Use db->data? / convert to u8 and use db[i] where needed.

> BR,
> Jani.
>
> >
> > Precompute the payload length in drm_parse_cea_ext and pass to
> > individual parsers to avoid casting struct cea_db pointer to u8
> > pointer where length is needed.
> >
> > Since the type of payload length is inconsistent in the file,
> > use u8, u16 where it was already in place, use int elsewhere.
> >
> > Signed-off-by: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@=
gmail.com>
> > ---
> >  drivers/gpu/drm/drm_edid.c | 63 ++++++++++++++++----------------------
> >  1 file changed, 27 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> > index 855beafb76ff..80442e8b8ac6 100644
> > --- a/drivers/gpu/drm/drm_edid.c
> > +++ b/drivers/gpu/drm/drm_edid.c
> > @@ -4977,11 +4977,8 @@ static int cea_db_tag(const struct cea_db *db)
> >       return db->tag_length >> 5;
> >  }
> >
> > -static int cea_db_payload_len(const void *_db)
> > +static int cea_db_payload_len(const struct cea_db *db)
> >  {
> > -     /* FIXME: Transition to passing struct cea_db * everywhere. */
> > -     const struct cea_db *db =3D _db;
> > -
> >       return db->tag_length & 0x1f;
> >  }
> >
> > @@ -5432,22 +5429,18 @@ static uint8_t hdr_metadata_type(const u8 *edid=
_ext)
> >  }
> >
> >  static void
> > -drm_parse_hdr_metadata_block(struct drm_connector *connector, const u8=
 *db)
> > +drm_parse_hdr_metadata_block(struct drm_connector *connector, const u8=
 *db, const u16 payload_len)
> >  {
> > -     u16 len;
> > -
> > -     len =3D cea_db_payload_len(db);
> > -
> >       connector->hdr_sink_metadata.hdmi_type1.eotf =3D
> >                                               eotf_supported(db);
> >       connector->hdr_sink_metadata.hdmi_type1.metadata_type =3D
> >                                               hdr_metadata_type(db);
> >
> > -     if (len >=3D 4)
> > +     if (payload_len >=3D 4)
> >               connector->hdr_sink_metadata.hdmi_type1.max_cll =3D db[4]=
;
> > -     if (len >=3D 5)
> > +     if (payload_len >=3D 5)
> >               connector->hdr_sink_metadata.hdmi_type1.max_fall =3D db[5=
];
> > -     if (len >=3D 6) {
> > +     if (payload_len >=3D 6) {
> >               connector->hdr_sink_metadata.hdmi_type1.min_cll =3D db[6]=
;
> >
> >               /* Calculate only when all values are available */
> > @@ -5457,20 +5450,18 @@ drm_parse_hdr_metadata_block(struct drm_connect=
or *connector, const u8 *db)
> >
> >  /* HDMI Vendor-Specific Data Block (HDMI VSDB, H14b-VSDB) */
> >  static void
> > -drm_parse_hdmi_vsdb_audio(struct drm_connector *connector, const u8 *d=
b)
> > +drm_parse_hdmi_vsdb_audio(struct drm_connector *connector, const u8 *d=
b, u8 payload_len)
> >  {
> > -     u8 len =3D cea_db_payload_len(db);
> > -
> > -     if (len >=3D 6 && (db[6] & (1 << 7)))
> > +     if (payload_len >=3D 6 && (db[6] & (1 << 7)))
> >               connector->eld[DRM_ELD_SAD_COUNT_CONN_TYPE] |=3D DRM_ELD_=
SUPPORTS_AI;
> >
> > -     if (len >=3D 10 && hdmi_vsdb_latency_present(db)) {
> > +     if (payload_len >=3D 10 && hdmi_vsdb_latency_present(db)) {
> >               connector->latency_present[0] =3D true;
> >               connector->video_latency[0] =3D db[9];
> >               connector->audio_latency[0] =3D db[10];
> >       }
> >
> > -     if (len >=3D 12 && hdmi_vsdb_i_latency_present(db)) {
> > +     if (payload_len >=3D 12 && hdmi_vsdb_i_latency_present(db)) {
> >               connector->latency_present[1] =3D true;
> >               connector->video_latency[1] =3D db[11];
> >               connector->audio_latency[1] =3D db[12];
> > @@ -5695,7 +5686,7 @@ static void drm_edid_to_eld(struct drm_connector =
*connector,
> >               case CTA_DB_VENDOR:
> >                       /* HDMI Vendor-Specific Data Block */
> >                       if (cea_db_is_hdmi_vsdb(db))
> > -                             drm_parse_hdmi_vsdb_audio(connector, (con=
st u8 *)db);
> > +                             drm_parse_hdmi_vsdb_audio(connector, (con=
st u8 *)db, len);
> >                       break;
> >               default:
> >                       break;
> > @@ -6122,7 +6113,7 @@ static void drm_parse_ycbcr420_deep_color_info(st=
ruct drm_connector *connector,
> >  }
> >
> >  static void drm_parse_dsc_info(struct drm_hdmi_dsc_cap *hdmi_dsc,
> > -                            const u8 *hf_scds)
> > +                            const u8 *hf_scds, int payload_len)
> >  {
> >       hdmi_dsc->v_1p2 =3D hf_scds[11] & DRM_EDID_DSC_1P2;
> >
> > @@ -6142,7 +6133,7 @@ static void drm_parse_dsc_info(struct drm_hdmi_ds=
c_cap *hdmi_dsc,
> >               /* Supports min 8 BPC if DSC 1.2 is supported*/
> >               hdmi_dsc->bpc_supported =3D 8;
> >
> > -     if (cea_db_payload_len(hf_scds) >=3D 12 && hf_scds[12]) {
> > +     if (payload_len >=3D 12 && hf_scds[12]) {
> >               u8 dsc_max_slices;
> >               u8 dsc_max_frl_rate;
> >
> > @@ -6188,13 +6179,13 @@ static void drm_parse_dsc_info(struct drm_hdmi_=
dsc_cap *hdmi_dsc,
> >               }
> >       }
> >
> > -     if (cea_db_payload_len(hf_scds) >=3D 13 && hf_scds[13])
> > +     if (payload_len >=3D 13 && hf_scds[13])
> >               hdmi_dsc->total_chunk_kbytes =3D hf_scds[13] & DRM_EDID_D=
SC_TOTAL_CHUNK_KBYTES;
> >  }
> >
> >  /* Sink Capability Data Structure */
> >  static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
> > -                                   const u8 *hf_scds)
> > +                                   const u8 *hf_scds, int payload_len)
> >  {
> >       struct drm_display_info *info =3D &connector->display_info;
> >       struct drm_hdmi_info *hdmi =3D &info->hdmi;
> > @@ -6247,8 +6238,8 @@ static void drm_parse_hdmi_forum_scds(struct drm_=
connector *connector,
> >
> >       drm_parse_ycbcr420_deep_color_info(connector, hf_scds);
> >
> > -     if (cea_db_payload_len(hf_scds) >=3D 11 && hf_scds[11]) {
> > -             drm_parse_dsc_info(hdmi_dsc, hf_scds);
> > +     if (payload_len >=3D 11 && hf_scds[11]) {
> > +             drm_parse_dsc_info(hdmi_dsc, hf_scds, payload_len);
> >               dsc_support =3D true;
> >       }
> >
> > @@ -6259,7 +6250,7 @@ static void drm_parse_hdmi_forum_scds(struct drm_=
connector *connector,
> >  }
> >
> >  static void drm_parse_hdmi_deep_color_info(struct drm_connector *conne=
ctor,
> > -                                        const u8 *hdmi)
> > +                                        const u8 *hdmi, const u8 paylo=
ad_len)
> >  {
> >       struct drm_display_info *info =3D &connector->display_info;
> >       unsigned int dc_bpc =3D 0;
> > @@ -6267,7 +6258,7 @@ static void drm_parse_hdmi_deep_color_info(struct=
 drm_connector *connector,
> >       /* HDMI supports at least 8 bpc */
> >       info->bpc =3D 8;
> >
> > -     if (cea_db_payload_len(hdmi) < 6)
> > +     if (payload_len < 6)
> >               return;
> >
> >       if (hdmi[6] & DRM_EDID_HDMI_DC_30) {
> > @@ -6320,18 +6311,17 @@ static void drm_parse_hdmi_deep_color_info(stru=
ct drm_connector *connector,
> >
> >  /* HDMI Vendor-Specific Data Block (HDMI VSDB, H14b-VSDB) */
> >  static void
> > -drm_parse_hdmi_vsdb_video(struct drm_connector *connector, const u8 *d=
b)
> > +drm_parse_hdmi_vsdb_video(struct drm_connector *connector, const u8 *d=
b, const u8 payload_len)
> >  {
> >       struct drm_display_info *info =3D &connector->display_info;
> > -     u8 len =3D cea_db_payload_len(db);
> >
> >       info->is_hdmi =3D true;
> >
> >       info->source_physical_address =3D (db[4] << 8) | db[5];
> >
> > -     if (len >=3D 6)
> > +     if (payload_len >=3D 6)
> >               info->dvi_dual =3D db[6] & 1;
> > -     if (len >=3D 7)
> > +     if (payload_len >=3D 7)
> >               info->max_tmds_clock =3D db[7] * 5000;
> >
> >       /*
> > @@ -6340,14 +6330,14 @@ drm_parse_hdmi_vsdb_video(struct drm_connector =
*connector, const u8 *db)
> >        * HDMI infoframe support was first added in HDMI 1.4. Assume the=
 sink
> >        * supports infoframes if HDMI_Video_present is set.
> >        */
> > -     if (len >=3D 8 && db[8] & BIT(5))
> > +     if (payload_len >=3D 8 && db[8] & BIT(5))
> >               info->has_hdmi_infoframe =3D true;
> >
> >       drm_dbg_kms(connector->dev, "[CONNECTOR:%d:%s] HDMI: DVI dual %d,=
 max TMDS clock %d kHz\n",
> >                   connector->base.id, connector->name,
> >                   info->dvi_dual, info->max_tmds_clock);
> >
> > -     drm_parse_hdmi_deep_color_info(connector, db);
> > +     drm_parse_hdmi_deep_color_info(connector, db, payload_len);
> >  }
> >
> >  /*
> > @@ -6410,12 +6400,13 @@ static void drm_parse_cea_ext(struct drm_connec=
tor *connector,
> >       cea_db_iter_for_each(db, &iter) {
> >               /* FIXME: convert parsers to use struct cea_db */
> >               const u8 *data =3D (const u8 *)db;
> > +             int len =3D cea_db_payload_len(db);
> >
> >               if (cea_db_is_hdmi_vsdb(db))
> > -                     drm_parse_hdmi_vsdb_video(connector, data);
> > +                     drm_parse_hdmi_vsdb_video(connector, data, len);
> >               else if (cea_db_is_hdmi_forum_vsdb(db) ||
> >                        cea_db_is_hdmi_forum_scdb(db))
> > -                     drm_parse_hdmi_forum_scds(connector, data);
> > +                     drm_parse_hdmi_forum_scds(connector, data, len);
> >               else if (cea_db_is_microsoft_vsdb(db))
> >                       drm_parse_microsoft_vsdb(connector, data);
> >               else if (cea_db_is_y420cmdb(db))
> > @@ -6425,7 +6416,7 @@ static void drm_parse_cea_ext(struct drm_connecto=
r *connector,
> >               else if (cea_db_is_vcdb(db))
> >                       drm_parse_vcdb(connector, data);
> >               else if (cea_db_is_hdmi_hdr_metadata_block(db))
> > -                     drm_parse_hdr_metadata_block(connector, data);
> > +                     drm_parse_hdr_metadata_block(connector, data, len=
);
> >               else if (cea_db_tag(db) =3D=3D CTA_DB_VIDEO)
> >                       parse_cta_vdb(connector, db);
> >               else if (cea_db_tag(db) =3D=3D CTA_DB_AUDIO)
> >
> > base-commit: 1d227fcc72223cbdd34d0ce13541cbaab5e0d72f
>
> --
> Jani Nikula, Intel
Thanks,
Vamsi

