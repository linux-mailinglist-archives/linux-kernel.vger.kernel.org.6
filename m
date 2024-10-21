Return-Path: <linux-kernel+bounces-374342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA889A68BC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4411F22CF8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7AD1F1310;
	Mon, 21 Oct 2024 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A74moh4s"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70615383A2
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514425; cv=none; b=Prm9g9slLpD9QmueJM75FN6X3jIGUvC2D6eQXKz0xCvBZuM8LnI86tzq/07t0wSvXDn/UZ5dFAnasdP/0s/Pn6mdEEvp3tLVCKrtTE5Jhfz+2HqPOlRe8YKQEtwn4qAm++vuzYOC8bextJyvcyE9nAIKm4pqn8msF2pJl0rDBMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514425; c=relaxed/simple;
	bh=CxEZIqEg8wNszQq5mrGd8GloIsdQxDrb1RfdzgyWymI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c+Pj194wH6CT/VrpHmr5uDJe47mj3V9yfDJQU06RgmsiAWrngJ/1iacF13Zad+a9ciV74GpjRdC/VS3+bRyWyjVyzhDWJINrrf46E/o8hJ9dt7oyU5maMjVM7VnqJEof5V1cyKBlkoF63HuYK7Bzyf8Rd/7cFOqYCX1E5oO8osg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A74moh4s; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f6e1f756so5095063e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 05:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729514421; x=1730119221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+myj29reR7jpyvTANnJto8Ls1EM1OXfIct5TmTN7KMs=;
        b=A74moh4sgR6I16RkflRIMzitLx6iVoI54D4LN6gFlVNNT/JYfQVZsBf3TH6r190kTz
         kZXpkOlGirviPLL4Ykx1rG8ibmvSCG2cQ7NbRk6hBEfSpRazV427YnEOpmrW1yoxASPo
         AUtyzyZHQlC1cw6MidcVBJDqTmY4f3IKRT0qSVFj5hRHBwapmqZqogyp1Mjom5BMP2Rs
         rJr0BHMxwYWrl9BVl6kKRox2cNtSpspvBg3WA5nDwNOQBwvQKDi496OmPqPI29+ZD31c
         34sy3NG4FT4kMEpAzfAIYsaNZIvnTdRgcZBIUEY+gWtDQCDHC6QPdihmTVT2gfTtI+al
         YdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729514421; x=1730119221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+myj29reR7jpyvTANnJto8Ls1EM1OXfIct5TmTN7KMs=;
        b=kRe5wWXo6pODgC0wy3VjMqwrfxposp19RWWTqxxwFV/R+SLSl6spFHxvV8T/bNLZMN
         zYYs945pq8EB323GqbqNte6ZC8r0/DQr69mDWuL4rjWibuE64ddmz9XCz+RrycoWWjoA
         TWfXv6Pf2gfZLpJV7CYm/i6eg8GJvhBJERHXmSL66ooxismzXwkmo7wMpAO1Wa5aFcnj
         cljeYuesIJ+tLOWaMEXwbVBaKLqI5V/ahntZbYJjhfhTlte1MH/PUA+9u4Bi8XH/uzu8
         DrtiaYeg7tFX1jrciJHkeCWtHmogqlY//yS34Bl4dMdOuqaCiS+ybcdW35naaCebMnKr
         YW+A==
X-Forwarded-Encrypted: i=1; AJvYcCXMQpMLqDzBPvxfXVzMCIBIyb3qHsOQs2kJlUdEpyCmxGNuVGi00zyoCXIcglMu9UualWU+vdWfWHAR6Vs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/UEatnsaR34yllD+stH4YhtT/Tbeshd0T56PNqJ1btRMMn9CA
	4J1vuCH5DDepbYQZc3aHs9M8TGG0FB4071tVCLxeAYRAJTKrCUNpUAJ506V7kCsRueHheJbyEhx
	ifB3Xbjr8+Nm6m8+it/rXI4grFD8=
X-Google-Smtp-Source: AGHT+IE+1Guy4iAsd122eIQfJ5WkRq+lGWl0v1VBeAACVwcKpdYkHtCUbjKxGu6WDkkK/MvVJ7Vy+pWNwiK3cw70tTE=
X-Received: by 2002:a05:6512:224b:b0:539:920a:f886 with SMTP id
 2adb3069b0e04-53a1545e324mr5335641e87.50.1729514421147; Mon, 21 Oct 2024
 05:40:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011152929.10145-1-vamsikrishna.brahmajosyula@gmail.com>
In-Reply-To: <20241011152929.10145-1-vamsikrishna.brahmajosyula@gmail.com>
From: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>
Date: Mon, 21 Oct 2024 18:10:10 +0530
Message-ID: <CAJvTgAicd_uYEMZqepsctFzqcQ-Kvv7Xr_b540OvPiE0fdDVQA@mail.gmail.com>
Subject: Re: [PATCH] drm/edid: transition to passing struct cea_db * to cae_db_payload_len
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch
Cc: skhan@linuxfoundation.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 8:59=E2=80=AFPM Vamsi Krishna Brahmajosyula
<vamsikrishna.brahmajosyula@gmail.com> wrote:
>
> Address the FIXME in cea_db_payload_len
>         Transition to passing struct cea_db * everywhere
>
> Precompute the payload length in drm_parse_cea_ext and pass to
> individual parsers to avoid casting struct cea_db pointer to u8
> pointer where length is needed.
>
> Since the type of payload length is inconsistent in the file,
> use u8, u16 where it was already in place, use int elsewhere.
>
> Signed-off-by: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gm=
ail.com>
> ---
>  drivers/gpu/drm/drm_edid.c | 63 ++++++++++++++++----------------------
>  1 file changed, 27 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 855beafb76ff..80442e8b8ac6 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -4977,11 +4977,8 @@ static int cea_db_tag(const struct cea_db *db)
>         return db->tag_length >> 5;
>  }
>
> -static int cea_db_payload_len(const void *_db)
> +static int cea_db_payload_len(const struct cea_db *db)
>  {
> -       /* FIXME: Transition to passing struct cea_db * everywhere. */
> -       const struct cea_db *db =3D _db;
> -
>         return db->tag_length & 0x1f;
>  }
>
> @@ -5432,22 +5429,18 @@ static uint8_t hdr_metadata_type(const u8 *edid_e=
xt)
>  }
>
>  static void
> -drm_parse_hdr_metadata_block(struct drm_connector *connector, const u8 *=
db)
> +drm_parse_hdr_metadata_block(struct drm_connector *connector, const u8 *=
db, const u16 payload_len)
>  {
> -       u16 len;
> -
> -       len =3D cea_db_payload_len(db);
> -
>         connector->hdr_sink_metadata.hdmi_type1.eotf =3D
>                                                 eotf_supported(db);
>         connector->hdr_sink_metadata.hdmi_type1.metadata_type =3D
>                                                 hdr_metadata_type(db);
>
> -       if (len >=3D 4)
> +       if (payload_len >=3D 4)
>                 connector->hdr_sink_metadata.hdmi_type1.max_cll =3D db[4]=
;
> -       if (len >=3D 5)
> +       if (payload_len >=3D 5)
>                 connector->hdr_sink_metadata.hdmi_type1.max_fall =3D db[5=
];
> -       if (len >=3D 6) {
> +       if (payload_len >=3D 6) {
>                 connector->hdr_sink_metadata.hdmi_type1.min_cll =3D db[6]=
;
>
>                 /* Calculate only when all values are available */
> @@ -5457,20 +5450,18 @@ drm_parse_hdr_metadata_block(struct drm_connector=
 *connector, const u8 *db)
>
>  /* HDMI Vendor-Specific Data Block (HDMI VSDB, H14b-VSDB) */
>  static void
> -drm_parse_hdmi_vsdb_audio(struct drm_connector *connector, const u8 *db)
> +drm_parse_hdmi_vsdb_audio(struct drm_connector *connector, const u8 *db,=
 u8 payload_len)
>  {
> -       u8 len =3D cea_db_payload_len(db);
> -
> -       if (len >=3D 6 && (db[6] & (1 << 7)))
> +       if (payload_len >=3D 6 && (db[6] & (1 << 7)))
>                 connector->eld[DRM_ELD_SAD_COUNT_CONN_TYPE] |=3D DRM_ELD_=
SUPPORTS_AI;
>
> -       if (len >=3D 10 && hdmi_vsdb_latency_present(db)) {
> +       if (payload_len >=3D 10 && hdmi_vsdb_latency_present(db)) {
>                 connector->latency_present[0] =3D true;
>                 connector->video_latency[0] =3D db[9];
>                 connector->audio_latency[0] =3D db[10];
>         }
>
> -       if (len >=3D 12 && hdmi_vsdb_i_latency_present(db)) {
> +       if (payload_len >=3D 12 && hdmi_vsdb_i_latency_present(db)) {
>                 connector->latency_present[1] =3D true;
>                 connector->video_latency[1] =3D db[11];
>                 connector->audio_latency[1] =3D db[12];
> @@ -5695,7 +5686,7 @@ static void drm_edid_to_eld(struct drm_connector *c=
onnector,
>                 case CTA_DB_VENDOR:
>                         /* HDMI Vendor-Specific Data Block */
>                         if (cea_db_is_hdmi_vsdb(db))
> -                               drm_parse_hdmi_vsdb_audio(connector, (con=
st u8 *)db);
> +                               drm_parse_hdmi_vsdb_audio(connector, (con=
st u8 *)db, len);
>                         break;
>                 default:
>                         break;
> @@ -6122,7 +6113,7 @@ static void drm_parse_ycbcr420_deep_color_info(stru=
ct drm_connector *connector,
>  }
>
>  static void drm_parse_dsc_info(struct drm_hdmi_dsc_cap *hdmi_dsc,
> -                              const u8 *hf_scds)
> +                              const u8 *hf_scds, int payload_len)
>  {
>         hdmi_dsc->v_1p2 =3D hf_scds[11] & DRM_EDID_DSC_1P2;
>
> @@ -6142,7 +6133,7 @@ static void drm_parse_dsc_info(struct drm_hdmi_dsc_=
cap *hdmi_dsc,
>                 /* Supports min 8 BPC if DSC 1.2 is supported*/
>                 hdmi_dsc->bpc_supported =3D 8;
>
> -       if (cea_db_payload_len(hf_scds) >=3D 12 && hf_scds[12]) {
> +       if (payload_len >=3D 12 && hf_scds[12]) {
>                 u8 dsc_max_slices;
>                 u8 dsc_max_frl_rate;
>
> @@ -6188,13 +6179,13 @@ static void drm_parse_dsc_info(struct drm_hdmi_ds=
c_cap *hdmi_dsc,
>                 }
>         }
>
> -       if (cea_db_payload_len(hf_scds) >=3D 13 && hf_scds[13])
> +       if (payload_len >=3D 13 && hf_scds[13])
>                 hdmi_dsc->total_chunk_kbytes =3D hf_scds[13] & DRM_EDID_D=
SC_TOTAL_CHUNK_KBYTES;
>  }
>
>  /* Sink Capability Data Structure */
>  static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
> -                                     const u8 *hf_scds)
> +                                     const u8 *hf_scds, int payload_len)
>  {
>         struct drm_display_info *info =3D &connector->display_info;
>         struct drm_hdmi_info *hdmi =3D &info->hdmi;
> @@ -6247,8 +6238,8 @@ static void drm_parse_hdmi_forum_scds(struct drm_co=
nnector *connector,
>
>         drm_parse_ycbcr420_deep_color_info(connector, hf_scds);
>
> -       if (cea_db_payload_len(hf_scds) >=3D 11 && hf_scds[11]) {
> -               drm_parse_dsc_info(hdmi_dsc, hf_scds);
> +       if (payload_len >=3D 11 && hf_scds[11]) {
> +               drm_parse_dsc_info(hdmi_dsc, hf_scds, payload_len);
>                 dsc_support =3D true;
>         }
>
> @@ -6259,7 +6250,7 @@ static void drm_parse_hdmi_forum_scds(struct drm_co=
nnector *connector,
>  }
>
>  static void drm_parse_hdmi_deep_color_info(struct drm_connector *connect=
or,
> -                                          const u8 *hdmi)
> +                                          const u8 *hdmi, const u8 paylo=
ad_len)
>  {
>         struct drm_display_info *info =3D &connector->display_info;
>         unsigned int dc_bpc =3D 0;
> @@ -6267,7 +6258,7 @@ static void drm_parse_hdmi_deep_color_info(struct d=
rm_connector *connector,
>         /* HDMI supports at least 8 bpc */
>         info->bpc =3D 8;
>
> -       if (cea_db_payload_len(hdmi) < 6)
> +       if (payload_len < 6)
>                 return;
>
>         if (hdmi[6] & DRM_EDID_HDMI_DC_30) {
> @@ -6320,18 +6311,17 @@ static void drm_parse_hdmi_deep_color_info(struct=
 drm_connector *connector,
>
>  /* HDMI Vendor-Specific Data Block (HDMI VSDB, H14b-VSDB) */
>  static void
> -drm_parse_hdmi_vsdb_video(struct drm_connector *connector, const u8 *db)
> +drm_parse_hdmi_vsdb_video(struct drm_connector *connector, const u8 *db,=
 const u8 payload_len)
>  {
>         struct drm_display_info *info =3D &connector->display_info;
> -       u8 len =3D cea_db_payload_len(db);
>
>         info->is_hdmi =3D true;
>
>         info->source_physical_address =3D (db[4] << 8) | db[5];
>
> -       if (len >=3D 6)
> +       if (payload_len >=3D 6)
>                 info->dvi_dual =3D db[6] & 1;
> -       if (len >=3D 7)
> +       if (payload_len >=3D 7)
>                 info->max_tmds_clock =3D db[7] * 5000;
>
>         /*
> @@ -6340,14 +6330,14 @@ drm_parse_hdmi_vsdb_video(struct drm_connector *c=
onnector, const u8 *db)
>          * HDMI infoframe support was first added in HDMI 1.4. Assume the=
 sink
>          * supports infoframes if HDMI_Video_present is set.
>          */
> -       if (len >=3D 8 && db[8] & BIT(5))
> +       if (payload_len >=3D 8 && db[8] & BIT(5))
>                 info->has_hdmi_infoframe =3D true;
>
>         drm_dbg_kms(connector->dev, "[CONNECTOR:%d:%s] HDMI: DVI dual %d,=
 max TMDS clock %d kHz\n",
>                     connector->base.id, connector->name,
>                     info->dvi_dual, info->max_tmds_clock);
>
> -       drm_parse_hdmi_deep_color_info(connector, db);
> +       drm_parse_hdmi_deep_color_info(connector, db, payload_len);
>  }
>
>  /*
> @@ -6410,12 +6400,13 @@ static void drm_parse_cea_ext(struct drm_connecto=
r *connector,
>         cea_db_iter_for_each(db, &iter) {
>                 /* FIXME: convert parsers to use struct cea_db */
>                 const u8 *data =3D (const u8 *)db;
> +               int len =3D cea_db_payload_len(db);
>
>                 if (cea_db_is_hdmi_vsdb(db))
> -                       drm_parse_hdmi_vsdb_video(connector, data);
> +                       drm_parse_hdmi_vsdb_video(connector, data, len);
>                 else if (cea_db_is_hdmi_forum_vsdb(db) ||
>                          cea_db_is_hdmi_forum_scdb(db))
> -                       drm_parse_hdmi_forum_scds(connector, data);
> +                       drm_parse_hdmi_forum_scds(connector, data, len);
>                 else if (cea_db_is_microsoft_vsdb(db))
>                         drm_parse_microsoft_vsdb(connector, data);
>                 else if (cea_db_is_y420cmdb(db))
> @@ -6425,7 +6416,7 @@ static void drm_parse_cea_ext(struct drm_connector =
*connector,
>                 else if (cea_db_is_vcdb(db))
>                         drm_parse_vcdb(connector, data);
>                 else if (cea_db_is_hdmi_hdr_metadata_block(db))
> -                       drm_parse_hdr_metadata_block(connector, data);
> +                       drm_parse_hdr_metadata_block(connector, data, len=
);
>                 else if (cea_db_tag(db) =3D=3D CTA_DB_VIDEO)
>                         parse_cta_vdb(connector, db);
>                 else if (cea_db_tag(db) =3D=3D CTA_DB_AUDIO)
>
> base-commit: 1d227fcc72223cbdd34d0ce13541cbaab5e0d72f
> --
> 2.47.0
>

gentle reminder..
Would love to hear any feedback on the patch.

Thanks,
Vamsi

