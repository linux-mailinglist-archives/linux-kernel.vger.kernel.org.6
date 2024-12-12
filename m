Return-Path: <linux-kernel+bounces-444013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7E39EFF57
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 23:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DDD01886949
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 22:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A1D1DE3D6;
	Thu, 12 Dec 2024 22:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XVSkuA6O"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6674A1DE2AE
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 22:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734042533; cv=none; b=imtN8fP57yJmG9em4ksRK30EKiu2bYv6cSGxD7wPsijmZYiWyZRBHosA0PR2pFvTwPiwNwV1ej2rIy+oMJUtDeHeL9seTs1KXy+XydelJsQxzjk05Vu2UkWQ4BkORtVKdnOXrAaF7p+MgSYz+wASK3Ykglb7c+0OuGKgx0b/zUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734042533; c=relaxed/simple;
	bh=HoBNthObslmhWykcBk73PV1/+0Lz9vXUEumOprk94/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpCtHO3TNutptntnWEDPexZQuXvbB0Bhztq3EsMVUDqA7kyoO79XCL53I6IChb2ralYi1Lo06R3dlkXq9nCkm9crwhoLhBixLMTfRGNda4Ii9GpoGCJ+G4AOCmHcg7YDwLa5bG+VradqTY5njGOO/xiwp3xu5Fu1BhLW4VPmjnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XVSkuA6O; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e3c8c1373ebso777146276.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 14:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734042525; x=1734647325; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JGKLJLQdx25/Ga+STlOpY9vQNmJk5LexWqUDLyRbV2g=;
        b=XVSkuA6OUWMctsHhwIDmkBPyVFbRNbGuS3IHwNgMDImfzvV/QFQxfEvTlUr7lMyNwq
         A74qGLK/qA1PG/b2mDdUQA4xcR8p8yInmCKPLnhp3XA/+0HqLeU/Dauj0jJNuYRh4Ou1
         zjykjYASJ1l+4hE8LLg3AqP2m9uvYihr+O3F24clMzfvUdKlE8ue8+O8dHc8EHrOCsKg
         krqV0a9iYtvFPRzYdLhfSsn/cNsEa0uPUB2Wc7UrDCSu9JRXfs2VEUoTBtV50iFQvu4X
         Uk4Ca24qmsO+peX6WXix4neFUM/KPdvBLiT0+TAglOjk1MkxLu97Wcfb5kkIA9Jtv35x
         8ROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734042525; x=1734647325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGKLJLQdx25/Ga+STlOpY9vQNmJk5LexWqUDLyRbV2g=;
        b=CKBnP5nvC452RoR3wNQEFdQp9/oavlWvEFbgQJmguHgNO0+k83M4fDT+PIbISXnK/b
         8gGGtAzSUijc0GoSg5j6Y4Bb8BDwplB/Z2QnqEotZFdmfLzEkMXGqkjzI3vw8nPSPJpa
         vk4pcVKd+1Xa/JhXUnf4+uH7vsJwZgrj2RUebJR/0J/BD7zDVEvnRgmb6wZOPW54w69d
         R1dB2etRLqSFgnu5EI3ZXMDFPbzhA6LzdKXDLqAG41WLM97hnGl0btYiF4OltaTsE6pO
         gavkU+Llr2RASCs37bKr92IEl+LiINiVNVHYsAmme1yRsA4aEintn7SDoF9v02wyGyQ5
         1euA==
X-Forwarded-Encrypted: i=1; AJvYcCWZPQmdkerKnjafmwel/ktUqp3sk1c3xnaKe5gWKqti8w/pMmCpd9/D4K0bm3G4DQuiRSKxT91nUBAuEqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzml/L3Js5VS3J4QtZaexJvBZfzd+32iUda7yT/DRKU7lVdXcL8
	jxKCL5fomHh3OumFzvqPDNO6j5iJ/uvLTI6gQIHTZGYuEE5Z1WxFsLtTFkHNzVwopAslIbl6xvA
	+D83sIO5pYz/Ow6G6hu1rooe/5JTBDstB7nH6dg==
X-Gm-Gg: ASbGncuDP0J+E0QEQym4WVOXxjs41MzzjhQSANDrqQOUD/TgWkzSrY8Kwl8PK3k6Or+
	mnVzen9E6zewBjIjNGo0mpncyrzg4SjSc+wdqmQ==
X-Google-Smtp-Source: AGHT+IEoFA6va5Vpt9diFX0HjcDxa+rf1e5iG7BZxupJBNypGbxlu35b6BCU48MhmnWRIivj4l+rd3CKU1QxWImoQ9E=
X-Received: by 2002:a05:6902:118b:b0:e29:1627:d4d3 with SMTP id
 3f1490d57ef6-e434e5e1407mr410610276.41.1734042525196; Thu, 12 Dec 2024
 14:28:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212-fd-dp-audio-fixup-v3-0-0b1c65e7dba3@linaro.org>
 <20241212-fd-dp-audio-fixup-v3-9-0b1c65e7dba3@linaro.org> <070dea1a-c300-4968-ba24-011625e4c133@quicinc.com>
In-Reply-To: <070dea1a-c300-4968-ba24-011625e4c133@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 13 Dec 2024 00:28:37 +0200
Message-ID: <CAA8EJpqO=AjVGEnZHNbM5+Mnu2gMN96kABBLM5XHh3NMMGFtjw@mail.gmail.com>
Subject: Re: [PATCH v3 09/14] drm/msm/dp: use msm_dp_utils_pack_sdp_header()
 for audio packets
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Paloma Arellano <quic_parellan@quicinc.com>, 
	Douglas Anderson <dianders@chromium.org>, Stephen Boyd <swboyd@chromium.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Dec 2024 at 23:41, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 12/11/2024 3:41 PM, Dmitry Baryshkov wrote:
> > Use msm_dp_utils_pack_sdp_header() and call msm_dp_write_link() directly
> > to program audio packet data. Use 0 as Packet ID, as it was not
> > programmed earlier.
> >
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/gpu/drm/msm/dp/dp_audio.c | 288 +++++++++-----------------------------
> >   1 file changed, 66 insertions(+), 222 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
> > index 5cbb11986460d1e4ed1890bdf66d0913e013083c..1aa52d5cc08684a49102e45ed6e40ac2b13497c7 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_audio.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_audio.c
> > @@ -14,6 +14,7 @@
> >   #include "dp_catalog.h"
> >   #include "dp_audio.h"
> >   #include "dp_panel.h"
> > +#include "dp_reg.h"
> >   #include "dp_display.h"
> >   #include "dp_utils.h"
> >
> > @@ -28,251 +29,94 @@ struct msm_dp_audio_private {
> >       struct msm_dp_audio msm_dp_audio;
> >   };
> >
> > -static u32 msm_dp_audio_get_header(struct msm_dp_catalog *catalog,
> > -             enum msm_dp_catalog_audio_sdp_type sdp,
> > -             enum msm_dp_catalog_audio_header_type header)
> > -{
> > -     return msm_dp_catalog_audio_get_header(catalog, sdp, header);
> > -}
> > -
> > -static void msm_dp_audio_set_header(struct msm_dp_catalog *catalog,
> > -             u32 data,
> > -             enum msm_dp_catalog_audio_sdp_type sdp,
> > -             enum msm_dp_catalog_audio_header_type header)
> > -{
> > -     msm_dp_catalog_audio_set_header(catalog, sdp, header, data);
> > -}
> > -
> >   static void msm_dp_audio_stream_sdp(struct msm_dp_audio_private *audio)
> >   {
> >       struct msm_dp_catalog *catalog = audio->catalog;
> > -     u32 value, new_value;
> > -     u8 parity_byte;
> > -
> > -     /* Config header and parity byte 1 */
> > -     value = msm_dp_audio_get_header(catalog,
> > -                     DP_AUDIO_SDP_STREAM, DP_AUDIO_SDP_HEADER_1);
> > -
> > -     new_value = 0x02;
> > -     parity_byte = msm_dp_utils_calculate_parity(new_value);
> > -     value |= ((new_value << HEADER_BYTE_1_BIT)
> > -                     | (parity_byte << PARITY_BYTE_1_BIT));
> > -     drm_dbg_dp(audio->drm_dev,
> > -                     "Header Byte 1: value = 0x%x, parity_byte = 0x%x\n",
> > -                     value, parity_byte);
> > -     msm_dp_audio_set_header(catalog, value,
> > -             DP_AUDIO_SDP_STREAM, DP_AUDIO_SDP_HEADER_1);
> > -
> > -     /* Config header and parity byte 2 */
> > -     value = msm_dp_audio_get_header(catalog,
> > -                     DP_AUDIO_SDP_STREAM, DP_AUDIO_SDP_HEADER_2);
> > -     new_value = value;
> > -     parity_byte = msm_dp_utils_calculate_parity(new_value);
> > -     value |= ((new_value << HEADER_BYTE_2_BIT)
> > -                     | (parity_byte << PARITY_BYTE_2_BIT));
> > -     drm_dbg_dp(audio->drm_dev,
> > -                     "Header Byte 2: value = 0x%x, parity_byte = 0x%x\n",
> > -                     value, parity_byte);
> > -
> > -     msm_dp_audio_set_header(catalog, value,
> > -             DP_AUDIO_SDP_STREAM, DP_AUDIO_SDP_HEADER_2);
> > -
> > -     /* Config header and parity byte 3 */
> > -     value = msm_dp_audio_get_header(catalog,
> > -                     DP_AUDIO_SDP_STREAM, DP_AUDIO_SDP_HEADER_3);
> > -
> > -     new_value = audio->channels - 1;
> > -     parity_byte = msm_dp_utils_calculate_parity(new_value);
> > -     value |= ((new_value << HEADER_BYTE_3_BIT)
> > -                     | (parity_byte << PARITY_BYTE_3_BIT));
> > -     drm_dbg_dp(audio->drm_dev,
> > -                     "Header Byte 3: value = 0x%x, parity_byte = 0x%x\n",
> > -             value, parity_byte);
> > -
> > -     msm_dp_audio_set_header(catalog, value,
> > -             DP_AUDIO_SDP_STREAM, DP_AUDIO_SDP_HEADER_3);
> > +     struct dp_sdp_header sdp_hdr = {
> > +             .HB0 = 0x00,
> > +             .HB1 = 0x02,
> > +             .HB2 = 0x00,
> > +             .HB3 = audio->channels - 1,
> > +     };
> > +     u32 header[2];
> > +
> > +     msm_dp_utils_pack_sdp_header(&sdp_hdr, header);
> > +
> > +     msm_dp_write_link(catalog, MMSS_DP_AUDIO_STREAM_0, header[0]);
> > +     msm_dp_write_link(catalog, MMSS_DP_AUDIO_STREAM_1, header[1]);
> >   }
>
> This patch is changing the programming behavior.
>
> Earlier it was using a read/modify/write on each register. Now, its just
>   a write. I checked a few chipsets, the reset value of registers was 0,
> so that part is okay.

Except that it was not a correct RMW, it was read, OR new data without
clearing the bitfield, write. So it has been working mostly by a
miracle,

>
> But, for the MMSS_DP_AUDIO_STREAM_0 register, earlier we were writing
> only the upper nibble, that is bits 15:0 of DP_AUDIO_SDP_HEADER_0 was
> kept as-it-is, but now this patch is changing that to 0. What was the
> reason for that change?

It is described in the commit message: "Use 0 as Packet ID, as it was not
programmed earlier."

>
> This is true for all the APIs being touched in this file.
>
> I guess the whole point of having that audio map in the catalog was to
> preserve the read values of these registers. I have to check what was
> the reason behind that as once again this was before I worked on this
> driver as well.
>
> So technically there are two parts to this change:
>
> 1) dropping read for each header and directly just writing it
> 2) Writing the registers directly instead of going through catalog
>
> It seems like (1) and (2) are independent. I hope (1) was not the reason
> to have started this whole rework.

Yes, the driver spends a lot of effort to preserve the data that will
be rewritten when the function is called to write the next header
byte. So it is useless. Only HB0 has been preserved, PacketID. If for
some reason we are generating a stream with the non-zero ID, it should
be explicit, not implicitly 'preserved'.

So, the reasons were:
- fix the RMW cycles to drop old values from the registers
- use new msm_dp_utils_pack_sdp_header()
- get rid of the useless indirection through the catalog and enum
msm_dp_catalog_audio_header_type
- write registers in an efficient way.
- if we ever have a set of functions to handle DP infoframes (like we
do for HDMI), make the MSM DP driver ready to be converted to such
functions.

>
> >
> >   static void msm_dp_audio_timestamp_sdp(struct msm_dp_audio_private *audio)
> >   {
> >       struct msm_dp_catalog *catalog = audio->catalog;
> > -     u32 value, new_value;
> > -     u8 parity_byte;
> > -
> > -     /* Config header and parity byte 1 */
> > -     value = msm_dp_audio_get_header(catalog,
> > -                     DP_AUDIO_SDP_TIMESTAMP, DP_AUDIO_SDP_HEADER_1);
> > -
> > -     new_value = 0x1;
> > -     parity_byte = msm_dp_utils_calculate_parity(new_value);
> > -     value |= ((new_value << HEADER_BYTE_1_BIT)
> > -                     | (parity_byte << PARITY_BYTE_1_BIT));
> > -     drm_dbg_dp(audio->drm_dev,
> > -                     "Header Byte 1: value = 0x%x, parity_byte = 0x%x\n",
> > -                     value, parity_byte);
> > -     msm_dp_audio_set_header(catalog, value,
> > -             DP_AUDIO_SDP_TIMESTAMP, DP_AUDIO_SDP_HEADER_1);
> > -
> > -     /* Config header and parity byte 2 */
> > -     value = msm_dp_audio_get_header(catalog,
> > -                     DP_AUDIO_SDP_TIMESTAMP, DP_AUDIO_SDP_HEADER_2);
> > -
> > -     new_value = 0x17;
> > -     parity_byte = msm_dp_utils_calculate_parity(new_value);
> > -     value |= ((new_value << HEADER_BYTE_2_BIT)
> > -                     | (parity_byte << PARITY_BYTE_2_BIT));
> > -     drm_dbg_dp(audio->drm_dev,
> > -                     "Header Byte 2: value = 0x%x, parity_byte = 0x%x\n",
> > -                     value, parity_byte);
> > -     msm_dp_audio_set_header(catalog, value,
> > -             DP_AUDIO_SDP_TIMESTAMP, DP_AUDIO_SDP_HEADER_2);
> > -
> > -     /* Config header and parity byte 3 */
> > -     value = msm_dp_audio_get_header(catalog,
> > -                     DP_AUDIO_SDP_TIMESTAMP, DP_AUDIO_SDP_HEADER_3);
> > -
> > -     new_value = (0x0 | (0x11 << 2));
> > -     parity_byte = msm_dp_utils_calculate_parity(new_value);
> > -     value |= ((new_value << HEADER_BYTE_3_BIT)
> > -                     | (parity_byte << PARITY_BYTE_3_BIT));
> > -     drm_dbg_dp(audio->drm_dev,
> > -                     "Header Byte 3: value = 0x%x, parity_byte = 0x%x\n",
> > -                     value, parity_byte);
> > -     msm_dp_audio_set_header(catalog, value,
> > -             DP_AUDIO_SDP_TIMESTAMP, DP_AUDIO_SDP_HEADER_3);
> > +     struct dp_sdp_header sdp_hdr = {
> > +             .HB0 = 0x00,
> > +             .HB1 = 0x01,
> > +             .HB2 = 0x17,
> > +             .HB3 = 0x0 | (0x11 << 2),
> > +     };
> > +     u32 header[2];
> > +
> > +     msm_dp_utils_pack_sdp_header(&sdp_hdr, header);
> > +
> > +     msm_dp_write_link(catalog, MMSS_DP_AUDIO_TIMESTAMP_0, header[0]);
> > +     msm_dp_write_link(catalog, MMSS_DP_AUDIO_TIMESTAMP_1, header[1]);
> >   }
> >
> >   static void msm_dp_audio_infoframe_sdp(struct msm_dp_audio_private *audio)
> >   {
> >       struct msm_dp_catalog *catalog = audio->catalog;
> > -     u32 value, new_value;
> > -     u8 parity_byte;
> > -
> > -     /* Config header and parity byte 1 */
> > -     value = msm_dp_audio_get_header(catalog,
> > -                     DP_AUDIO_SDP_INFOFRAME, DP_AUDIO_SDP_HEADER_1);
> > -
> > -     new_value = 0x84;
> > -     parity_byte = msm_dp_utils_calculate_parity(new_value);
> > -     value |= ((new_value << HEADER_BYTE_1_BIT)
> > -                     | (parity_byte << PARITY_BYTE_1_BIT));
> > -     drm_dbg_dp(audio->drm_dev,
> > -                     "Header Byte 1: value = 0x%x, parity_byte = 0x%x\n",
> > -                     value, parity_byte);
> > -     msm_dp_audio_set_header(catalog, value,
> > -             DP_AUDIO_SDP_INFOFRAME, DP_AUDIO_SDP_HEADER_1);
> > -
> > -     /* Config header and parity byte 2 */
> > -     value = msm_dp_audio_get_header(catalog,
> > -                     DP_AUDIO_SDP_INFOFRAME, DP_AUDIO_SDP_HEADER_2);
> > -
> > -     new_value = 0x1b;
> > -     parity_byte = msm_dp_utils_calculate_parity(new_value);
> > -     value |= ((new_value << HEADER_BYTE_2_BIT)
> > -                     | (parity_byte << PARITY_BYTE_2_BIT));
> > -     drm_dbg_dp(audio->drm_dev,
> > -                     "Header Byte 2: value = 0x%x, parity_byte = 0x%x\n",
> > -                     value, parity_byte);
> > -     msm_dp_audio_set_header(catalog, value,
> > -             DP_AUDIO_SDP_INFOFRAME, DP_AUDIO_SDP_HEADER_2);
> > -
> > -     /* Config header and parity byte 3 */
> > -     value = msm_dp_audio_get_header(catalog,
> > -                     DP_AUDIO_SDP_INFOFRAME, DP_AUDIO_SDP_HEADER_3);
> > -
> > -     new_value = (0x0 | (0x11 << 2));
> > -     parity_byte = msm_dp_utils_calculate_parity(new_value);
> > -     value |= ((new_value << HEADER_BYTE_3_BIT)
> > -                     | (parity_byte << PARITY_BYTE_3_BIT));
> > -     drm_dbg_dp(audio->drm_dev,
> > -                     "Header Byte 3: value = 0x%x, parity_byte = 0x%x\n",
> > -                     new_value, parity_byte);
> > -     msm_dp_audio_set_header(catalog, value,
> > -             DP_AUDIO_SDP_INFOFRAME, DP_AUDIO_SDP_HEADER_3);
> > +     struct dp_sdp_header sdp_hdr = {
> > +             .HB0 = 0x00,
> > +             .HB1 = 0x84,
> > +             .HB2 = 0x1b,
> > +             .HB3 = 0x0 | (0x11 << 2),
> > +     };
> > +     u32 header[2];
> > +
> > +     msm_dp_utils_pack_sdp_header(&sdp_hdr, header);
> > +
> > +     msm_dp_write_link(catalog, MMSS_DP_AUDIO_INFOFRAME_0, header[0]);
> > +     msm_dp_write_link(catalog, MMSS_DP_AUDIO_INFOFRAME_1, header[1]);
> >   }
> >
> >   static void msm_dp_audio_copy_management_sdp(struct msm_dp_audio_private *audio)
> >   {
> >       struct msm_dp_catalog *catalog = audio->catalog;
> > -     u32 value, new_value;
> > -     u8 parity_byte;
> > -
> > -     /* Config header and parity byte 1 */
> > -     value = msm_dp_audio_get_header(catalog,
> > -                     DP_AUDIO_SDP_COPYMANAGEMENT, DP_AUDIO_SDP_HEADER_1);
> > -
> > -     new_value = 0x05;
> > -     parity_byte = msm_dp_utils_calculate_parity(new_value);
> > -     value |= ((new_value << HEADER_BYTE_1_BIT)
> > -                     | (parity_byte << PARITY_BYTE_1_BIT));
> > -     drm_dbg_dp(audio->drm_dev,
> > -                     "Header Byte 1: value = 0x%x, parity_byte = 0x%x\n",
> > -                     value, parity_byte);
> > -     msm_dp_audio_set_header(catalog, value,
> > -             DP_AUDIO_SDP_COPYMANAGEMENT, DP_AUDIO_SDP_HEADER_1);
> > -
> > -     /* Config header and parity byte 2 */
> > -     value = msm_dp_audio_get_header(catalog,
> > -                     DP_AUDIO_SDP_COPYMANAGEMENT, DP_AUDIO_SDP_HEADER_2);
> > -
> > -     new_value = 0x0F;
> > -     parity_byte = msm_dp_utils_calculate_parity(new_value);
> > -     value |= ((new_value << HEADER_BYTE_2_BIT)
> > -                     | (parity_byte << PARITY_BYTE_2_BIT));
> > -     drm_dbg_dp(audio->drm_dev,
> > -                     "Header Byte 2: value = 0x%x, parity_byte = 0x%x\n",
> > -                     value, parity_byte);
> > -     msm_dp_audio_set_header(catalog, value,
> > -             DP_AUDIO_SDP_COPYMANAGEMENT, DP_AUDIO_SDP_HEADER_2);
> > -
> > -     /* Config header and parity byte 3 */
> > -     value = msm_dp_audio_get_header(catalog,
> > -                     DP_AUDIO_SDP_COPYMANAGEMENT, DP_AUDIO_SDP_HEADER_3);
> > -
> > -     new_value = 0x0;
> > -     parity_byte = msm_dp_utils_calculate_parity(new_value);
> > -     value |= ((new_value << HEADER_BYTE_3_BIT)
> > -                     | (parity_byte << PARITY_BYTE_3_BIT));
> > -     drm_dbg_dp(audio->drm_dev,
> > -                     "Header Byte 3: value = 0x%x, parity_byte = 0x%x\n",
> > -                     value, parity_byte);
> > -     msm_dp_audio_set_header(catalog, value,
> > -             DP_AUDIO_SDP_COPYMANAGEMENT, DP_AUDIO_SDP_HEADER_3);
> > +     struct dp_sdp_header sdp_hdr = {
> > +             .HB0 = 0x00,
> > +             .HB1 = 0x05,
> > +             .HB2 = 0x0f,
> > +             .HB3 = 0x00,
> > +     };
> > +     u32 header[2];
> > +
> > +     msm_dp_utils_pack_sdp_header(&sdp_hdr, header);
> > +
> > +     msm_dp_write_link(catalog, MMSS_DP_AUDIO_COPYMANAGEMENT_0, header[0]);
> > +     msm_dp_write_link(catalog, MMSS_DP_AUDIO_COPYMANAGEMENT_1, header[1]);
> >   }
> >
> >   static void msm_dp_audio_isrc_sdp(struct msm_dp_audio_private *audio)
> >   {
> >       struct msm_dp_catalog *catalog = audio->catalog;
> > -     u32 value, new_value;
> > -     u8 parity_byte;
> > -
> > -     /* Config header and parity byte 1 */
> > -     value = msm_dp_audio_get_header(catalog,
> > -                     DP_AUDIO_SDP_ISRC, DP_AUDIO_SDP_HEADER_1);
> > -
> > -     new_value = 0x06;
> > -     parity_byte = msm_dp_utils_calculate_parity(new_value);
> > -     value |= ((new_value << HEADER_BYTE_1_BIT)
> > -                     | (parity_byte << PARITY_BYTE_1_BIT));
> > -     drm_dbg_dp(audio->drm_dev,
> > -                     "Header Byte 1: value = 0x%x, parity_byte = 0x%x\n",
> > -                     value, parity_byte);
> > -     msm_dp_audio_set_header(catalog, value,
> > -             DP_AUDIO_SDP_ISRC, DP_AUDIO_SDP_HEADER_1);
> > -
> > -     /* Config header and parity byte 2 */
> > -     value = msm_dp_audio_get_header(catalog,
> > -                     DP_AUDIO_SDP_ISRC, DP_AUDIO_SDP_HEADER_2);
> > -
> > -     new_value = 0x0F;
> > -     parity_byte = msm_dp_utils_calculate_parity(new_value);
> > -     value |= ((new_value << HEADER_BYTE_2_BIT)
> > -                     | (parity_byte << PARITY_BYTE_2_BIT));
> > -     drm_dbg_dp(audio->drm_dev,
> > -                     "Header Byte 2: value = 0x%x, parity_byte = 0x%x\n",
> > -                     value, parity_byte);
> > -     msm_dp_audio_set_header(catalog, value,
> > -             DP_AUDIO_SDP_ISRC, DP_AUDIO_SDP_HEADER_2);
> > +     struct dp_sdp_header sdp_hdr = {
> > +             .HB0 = 0x00,
> > +             .HB1 = 0x06,
> > +             .HB2 = 0x0f,
> > +             .HB3 = 0x00,
> > +     };
> > +     u32 header[2];
> > +     u32 reg;
> > +
> > +     /* XXX: is it necessary to preserve this field? */
> > +     reg = msm_dp_read_link(catalog, MMSS_DP_AUDIO_ISRC_1);
> > +     sdp_hdr.HB3 = FIELD_GET(HEADER_3_MASK, reg);
> > +
> > +     msm_dp_utils_pack_sdp_header(&sdp_hdr, header);
> > +
> > +     msm_dp_write_link(catalog, MMSS_DP_AUDIO_ISRC_0, header[0]);
> > +     msm_dp_write_link(catalog, MMSS_DP_AUDIO_ISRC_1, header[1]);
> >   }
> >
> >   static void msm_dp_audio_setup_sdp(struct msm_dp_audio_private *audio)
> >



-- 
With best wishes
Dmitry

