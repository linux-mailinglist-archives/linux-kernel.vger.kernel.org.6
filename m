Return-Path: <linux-kernel+bounces-265852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E99B93F6DC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0AE8281966
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9479C14E2E2;
	Mon, 29 Jul 2024 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jmooqYQ5"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BBD149015
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722260426; cv=none; b=qSIe9RkL5l0eENr+osoPzdkJmmIBUfgLoxxQ1yN4j0cMMketyeOU95qQMfH6zMeIaS2VWppk13z/fAKTHQl/CJBfYr/i0lHwHh+WsbK56SBwNRT5OcJvJYcDOPjCJnLo6Yx1OJOegWZ/UGrUmyZ/88t0GBxNCaic0p3Ngi8yBOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722260426; c=relaxed/simple;
	bh=m5Lwugng7Q3IhOI9RCpRkt2R9HhMleNT/XtcE9TngtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fon6XiIAOfkq80GOOeq89bgtORX45Qklez//TdtiQ7uI4rNt89AeSa3ssd7McNzyMKh3M0Wcc7qdnhfvqX9dnis62px1Le1GQ7HloH0jyg8GlhYtRszNw7PWQVhCda8n70EXL3TOCb2SY7uDoX1D6QEh0p0Mq3vWadl9hyeFYYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jmooqYQ5; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b7af49e815so20875436d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 06:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722260423; x=1722865223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OybnryKVs2UqunE+HbITQkTW5YxjXd43/aMmkgTPKM=;
        b=jmooqYQ5AVyVgMWlo93EqrBoGXuY8fuA/XqtpdnplqyjvcMTXgjVgmzbeV59/Sbte/
         egjC522M/pSwRvUTnV8gQOL9x6bO3bxvxTPxB9p9TyGgU928J+5xYfrO4E8WPdQ14v2j
         0xQMn739N0RpKQZ3C5qQyzWoUNTP9+4s6DR7EM4a64jEvjgIMoCxjFkYC4unXIY8BASh
         iTb6edNvryXQVLRRRPwRGyIjYbk4Zo65V7AlKM8obzTOY0andq68If86XR5hfs+IYMIQ
         J83H9eO5m2O31pPPtmC1le9zcFXpciCqPS9NqFWS/bhKsdLPvfMaTpPMQzpFrdFTTEWx
         krDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722260423; x=1722865223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OybnryKVs2UqunE+HbITQkTW5YxjXd43/aMmkgTPKM=;
        b=bbr3NkxtT0IH4nexSDEXXGOl8bHD8UF92YsEpZ69PQZW8ufD2SMhRVdNI1gNwFiF29
         4FCaQjoSSTuuDOYriaY9HCiIVBUjTchGWb1AkvyCOnzrTDFQd3aim0KDeViUHoK4nGuj
         3rLijlSz69Sd311dFbHfVUqYQ//SWThjHv/NP9yqLertVyKG8Nu9uCOsTtjBjmt1HOAO
         M08UZzSHgIYtyO8Wz8YSerOXTC8ISkg5Xoan0cAr40UBezTHD3CG3IhRtnD7VvAG4hQ+
         rFbY8GG7gjjZX2Iss4pIyRDNE4FhBsb06ZQ04GuMNHrqIMbi3FnzUk16ujkxAfSMOi7N
         MIdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2f6Jov7SaqQ9aMKreCa2IX2zvTEsO+B09ZpbyIGmrE+WW03BLmiRQQpV8XgqJwzmir5Jh9Cb14Q+1MzbKGDHx2y5aA2kUR0HwjS2P
X-Gm-Message-State: AOJu0YyOxgAn4sZ2jEqV6nQ1F6nlIJDtIqCTDnHx5ZJqdqkHuK5iOnq6
	BsDCIQBOuOio0lWXJGEq2ShcU9Cag4u0lyWnDBwoJ/zX16adYI6Md97Xt/YaGqNE3c0Bj2ODfyv
	7FwPza5H3sYUoMDRFmhvtAgCOiietXF18iKa0wg==
X-Google-Smtp-Source: AGHT+IGSawRp512TpjUvjVB4Ov7SQcRSb7iRQeyOf4EprnazA+zHIHl6RfmOfDlEMz9/ziMVEreqiWeoj15Jc4GLZnA=
X-Received: by 2002:a05:6214:1d2e:b0:6b7:42aa:3358 with SMTP id
 6a1803df08f44-6bb55a7cb75mr88544056d6.31.1722260423344; Mon, 29 Jul 2024
 06:40:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704-add-mtk-isp-3-0-support-v5-0-bfccccc5ec21@baylibre.com>
 <20240704-add-mtk-isp-3-0-support-v5-4-bfccccc5ec21@baylibre.com> <85c54f0b1b8bb5d9026c67109a3526fd95cc013b.camel@mediatek.com>
In-Reply-To: <85c54f0b1b8bb5d9026c67109a3526fd95cc013b.camel@mediatek.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 29 Jul 2024 15:40:09 +0200
Message-ID: <CAEHHSvZ2etjPKq0MqHYD=hjs19Yy+DJLwXGGorJK7q2tW2dfRQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 camsv
To: =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
Cc: "mchehab@kernel.org" <mchehab@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, =?UTF-8?B?QW5keSBIc2llaCAo6Kyd5pm655qTKQ==?= <Andy.Hsieh@mediatek.com>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
	"laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"paul.elder@ideasonboard.com" <paul.elder@ideasonboard.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"fsylvestre@baylibre.com" <fsylvestre@baylibre.com>, "pnguyen@baylibre.com" <pnguyen@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 18 juil. 2024 =C3=A0 04:54, CK Hu (=E8=83=A1=E4=BF=8A=E5=85=89) <ck=
.hu@mediatek.com> a =C3=A9crit :
>
> Hi, Julien:
>
> On Thu, 2024-07-04 at 15:36 +0200, Julien Stephan wrote:
> >
> > External email : Please do not click links or open attachments until yo=
u have verified the sender or the content.
> >  From: Phi-bang Nguyen <pnguyen@baylibre.com>
> >
> > This driver provides a path to bypass the SoC ISP so that image data
> > coming from the SENINF can go directly into memory without any image
> > processing. This allows the use of an external ISP.
> >
> > Signed-off-by: Phi-bang Nguyen <pnguyen@baylibre.com>
> > Signed-off-by: Florian Sylvestre <fsylvestre@baylibre.com>
> > [Paul Elder fix irq locking]
> > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > Co-developed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Co-developed-by: Julien Stephan <jstephan@baylibre.com>
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---
>
> [snip]
>
> > +static int mtk_cam_vb2_start_streaming(struct vb2_queue *vq,
> > +       unsigned int count)
> > +{
> > +struct mtk_cam_dev *cam =3D vb2_get_drv_priv(vq);
> > +struct mtk_cam_dev_buffer *buf;
> > +struct mtk_cam_video_device *vdev =3D
> > +vb2_queue_to_mtk_cam_video_device(vq);
> > +struct device *dev =3D cam->dev;
> > +const struct v4l2_pix_format_mplane *fmt =3D &vdev->format;
> > +int ret;
> > +unsigned long flags;
> > +
> > +if (pm_runtime_get_sync(dev) < 0) {
> > +dev_err(dev, "failed to get pm_runtime\n");
> > +pm_runtime_put_autosuspend(dev);
> > +return -1;
> > +}
> > +
> > +(*cam->hw_functions->mtk_cam_setup)(cam, fmt->width, fmt->height,
> > +fmt->plane_fmt[0].bytesperline, vdev->fmtinfo->code);
> > +
> > +
> > +/* Enable CMOS and VF */
> > +mtk_cam_cmos_vf_enable(cam, true, true);
> > +
> > +mutex_lock(&cam->op_lock);
> > +
> > +ret =3D mtk_cam_verify_format(cam);
> > +if (ret < 0)
> > +goto fail_unlock;
> > +
> > +/* Start streaming of the whole pipeline now*/
> > +if (!cam->pipeline.start_count) {
> > +ret =3D media_pipeline_start(vdev->vdev.entity.pads,
> > +   &cam->pipeline);
> > +if (ret) {
> > +dev_err(dev, "failed to start pipeline:%d\n", ret);
> > +goto fail_unlock;
> > +}
> > +}
> > +
> > +/* Media links are fixed after media_pipeline_start */
> > +cam->stream_count++;
> > +
> > +cam->sequence =3D (unsigned int)-1;
> > +
> > +/* Stream on the sub-device */
> > +ret =3D v4l2_subdev_call(&cam->subdev, video, s_stream, 1);
> > +if (ret)
> > +goto fail_no_stream;
> > +
> > +mutex_unlock(&cam->op_lock);
> > +
> > +/* Create dummy buffer */
> > +cam->dummy_size =3D fmt->plane_fmt[0].sizeimage;
> > +
> > +cam->dummy.vaddr =3D dma_alloc_coherent(cam->dev, cam->dummy_size,
> > +      &cam->dummy.daddr, GFP_KERNEL);
>
> Dummy buffer cost much in DRAM footprint. I think we can get rid of
> this dummy buffer. If no buffer is queued from user space, call
> mtk_camsv30_cmos_vf_hw_disable() to stop write data into DRAM. After
> buffer is queued from user space, call mtk_camsv30_cmos_vf_hw_enable()
> to start write data into DRAM.
>

Hi CK,

IMHO it does not cost that much. A long time ago, we tried to remove
it, but we faced an issue (can't remember what :/).
Moreover, some other driver already uses the dummy buffer
implementation, if I am not wrong.

Cheers
Julien

> Regards,
> CK
>
> > +if (!cam->dummy.vaddr) {
> > +ret =3D -ENOMEM;
> > +goto fail_no_buffer;
> > +}
> > +
> > +/* update first buffer address */
> > +
> > +/* added the buffer into the tracking list */
> > +spin_lock_irqsave(&cam->irqlock, flags);
> > +if (list_empty(&cam->buf_list)) {
> > +(*cam->hw_functions->mtk_cam_update_buffers_add)(cam, &cam->dummy);
> > +cam->is_dummy_used =3D true;
> > +} else {
> > +buf =3D list_first_entry_or_null(&cam->buf_list,
> > +       struct mtk_cam_dev_buffer,
> > +       list);
> > +(*cam->hw_functions->mtk_cam_update_buffers_add)(cam, buf);
> > +cam->is_dummy_used =3D false;
> > +}
> > +spin_unlock_irqrestore(&cam->irqlock, flags);
> > +
> > +return 0;
> > +
> > +fail_no_buffer:
> > +mutex_lock(&cam->op_lock);
> > +v4l2_subdev_call(&cam->subdev, video, s_stream, 0);
> > +fail_no_stream:
> > +cam->stream_count--;
> > +if (cam->stream_count =3D=3D 0)
> > +media_pipeline_stop(vdev->vdev.entity.pads);
> > +fail_unlock:
> > +mutex_unlock(&cam->op_lock);
> > +mtk_cam_vb2_return_all_buffers(cam, VB2_BUF_STATE_QUEUED);
> > +
> > +return ret;
> > +}
> > +
>
> ************* MEDIATEK Confidentiality Notice ********************
> The information contained in this e-mail message (including any
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be
> conveyed only to the designated recipient(s). Any use, dissemination,
> distribution, printing, retaining or copying of this e-mail (including it=
s
> attachments) by unintended recipient(s) is strictly prohibited and may
> be unlawful. If you are not an intended recipient of this e-mail, or beli=
eve
> that you have received this e-mail in error, please notify the sender
> immediately (by replying to this e-mail), delete any and all copies of
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!

