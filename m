Return-Path: <linux-kernel+bounces-565634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 769E3A66C79
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AEB8178B1A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37384205AD0;
	Tue, 18 Mar 2025 07:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TwlpGAb0"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E941B1EB5D3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283856; cv=none; b=A675G18yR0Abs9JrEqoJnAS/RgisjMwOQgKmlbFRgmarvYcyoFd5TXi1gDD+se5UZb7mEnaN4XNIQOtp58j+aqAxJeBSmk6Yign/yddZlKPV6mcQPUwpKIRV0B7HOpPrAvx2IVKPvysCSI/5wk3RhI8rnduCS407n9npSnbZffY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283856; c=relaxed/simple;
	bh=dychQpUbmrOuwM+4mAzMSW53vRZ7cpZ33wD/E6jpFug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HweuHWHS1ziH857oB5soMpezGiTfo2oVqlCi0kN7c7dYiXABKVXAYLDNEn2SbqhlPPZ+2spTOi8Ul2NYzAoD71GI4SR/N5LtzYL8IVO2Fl7K5O0JJuk0CEVNyqOgzLpu2voawDGWwoC2opDYTC9uFhDLjMba5vIltrHYc90M5+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TwlpGAb0; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30bf3f3539dso53180231fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 00:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742283852; x=1742888652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AY4nrcK+Zp55l8IKfUmGd4cDhlQMOGx6qxnOrnPzDs0=;
        b=TwlpGAb0ltRFiXGoBcMwsKmrPkaz5/Zx3gEsd8ASNblQrtcVlIWSoNMYJxV/BwmXup
         QMPFLv2Ipa+nu3mX+JrSJmrqVyHqbeWqzXSxtvtmi3U7CmIq2tXH5o07N5WifmpmBzJW
         cfBQHtesgvYGo7udhIAdkrMX7AEZiz+Vf6kFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742283852; x=1742888652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AY4nrcK+Zp55l8IKfUmGd4cDhlQMOGx6qxnOrnPzDs0=;
        b=AmtDrhaUCdm8RxLJ6fXlncoUyE3pjlE7+rVohcI4za/AUbCkMLN2xuL7iLQosk2NjV
         05C2qWYJqgLX7y97JFeVGct4oakzyZKwZCeUVUn8RHxMtQ+ZWa9a/MhrEF8sFiymL6sC
         +x6ox4ETOwGrg22RNHrmY2ALpOrWkPOnbSRy7fmaivqaSBoJag5Causypqi00/2O9dUz
         kz4A7v4bb1fV4t36Ff7jST91BuGh3Jr27LA6kBQ6ysTcVVZzuRKU98ylBaP11V0iNnbC
         m1EPsUn2d+nSta3SF6LgEWUfoPAzbuXDFuooG+GKeuJgy7aDMN+nLK8frBMHZbRLKSME
         F95g==
X-Forwarded-Encrypted: i=1; AJvYcCXozjZ88BR+VnXGFAum/INNey40hvKj40ATLb3+m8hlku/mDur/fD2+9M9q9SylHFgzolS3fmO6lFj8Q04=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB1AoxXmvRLU6ls4IUK7xhABRv7UoCOsj3OXIIqu8OMfm8VmFA
	pBisaQPiQvJzhtKLbkgmvf+NgtJTV1t7S4mmwptkaiNbK6QQwtW+ziBYvV7W/O14pATitdUqxBp
	LvxygKjwwow17yHg1/d/c/khaN3WOrDixpl9u
X-Gm-Gg: ASbGnctXzk3913++pq1lSn2xZ1yUMV+V2Lw09WhsPSjtvQq2V5XoDCOz00sup3htM0O
	kPzsntaWTzdwMVa/B0J2TNmDE0S+yG+B0qXwYTHv/U/W7eoI/meLtA8vqcOFStvodK0vp1M1l13
	o84tRLXraephVarwy3UDw5HB2MOnZmDpwTEJ+8fEU82mg8mNi6zZ5sgA==
X-Google-Smtp-Source: AGHT+IF+773ci4UoV+sGzHQYu4ESZ9jtnDsvpdSF2LHhzTO4GxyVaJ4Tz3KvEFLSLVW7uYN+ywJG4Jl3VDfydU66Nlg=
X-Received: by 2002:a05:651c:1a0a:b0:308:ee65:7f44 with SMTP id
 38308e7fff4ca-30cd95ccf10mr18564791fa.8.1742283851907; Tue, 18 Mar 2025
 00:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317083822.891-1-jjian.zhou@mediatek.com> <375d5281-41f5-49e8-ac20-d58931c0c1f9@collabora.com>
In-Reply-To: <375d5281-41f5-49e8-ac20-d58931c0c1f9@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 18 Mar 2025 15:44:00 +0800
X-Gm-Features: AQ5f1JoL_4-3vsBbckwxOs1U7jI_JX94-Mf3iV6qaZp6QY7f8KVlHZilsseLfY4
Message-ID: <CAGXv+5G4KRbv=qcKurn5u300XPp4KNovmUD9OBfX7mKk57tucg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/3] add VCP mailbox and IPC driver
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Jjian Zhou <jjian.zhou@mediatek.com>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 6:07=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 17/03/25 09:38, Jjian Zhou ha scritto:
> > The VCP mailbox has 5 groups. Each group has corresponding interrupts,
> > registers, and 64 slots (each slot is 4 bytes). Since different feature=
s
> > share one of the mailbox groups, the VCP mailbox needs to establish a
> > send table and a receive table. The send table is used to record the
> > feature ID, mailbox ID, and the number of slots occupied. The receive t=
able
> > is used to record the feature ID, mailbox ID, the number of slots occup=
ied,
> > and the receive options. The API setup_mbox_table in mtk-vcp-ipc.c calc=
ulates
> > the slot offset and pin index for each feature ID based on the mailbox =
ID and
> > slot number in the send and receive tables (several slots form a pin, a=
nd
> > each pin can trigger an interrupt). These descriptions are written in t=
he
> > mtk-vcp-ipc.c file -- we call it the IPC layer.
> >
> > We have two questions:
> > How should we describe the mailbox and IPI?
> > Can the intermediate IPC layer be rewritten as a virtual mailbox layer?
> >
>
> So, for this remote processor messaging system you have:
>   - Dynamic channel allocation
>     - Each channel has its own endpoint

The rpmsg model has:

- device -> the remote processor
- channel
- endpoint

However here for the VCP and possibly all the coprocessors using the
tinysys model, channel and endpoint are basically the same. If we
consider the "channel" to be the storage plus the interrupt vector,
and the "endpoint" to be the function running on the remote processor
servicing a given IPI ID, then it's always one endpoint per channel.

IMHO rpmsg gives too much latitude to make things confusing here.

rpmsg also requires the remote processor to support name service
announcements, which really doesn't exist. The endpoints and how
they map to the various hardware mailbox interrupt vectors and
storage is statically allocated, and thus needs to be described
in the driver.

>     - Each channel has its own interrupt
>   - Data send operation
>     - Both with and without ACK indication from the remote processor
>     - To channel -> endpoint
>   - Data receive operation
>     - From channel <- endpoint
>     - When interrupt fires
>     - Could use polling to avoid blocking in a few cases
>   - A custom message structure not adhering to any standard
>
> Check drivers/rpmsg/ :-)

While discussing this internally, I felt like that wasn't a really
correct model. IIUC rpmsg was first created to allow userspace to
pass messages to the remote processor. Then somehow devices were
being created on top of those channels.

Also, the existing mtk_rpmsg driver seemed a bit weird, like requiring
a DT node for each rpmsg endpoint.

That's why I thought mailboxes made more sense, as the terminology mapped
better. As a result I never brought up rpmsg in the discussion.

Perhaps that could be improved with better documentation for the MediaTek
specific implementation.

> On MediaTek platforms, there are many IPI to handle in many subsystems fo=
r
> all of the remote processors that are integrated in the SoC and, at this
> point, you might as well just aggregate all of the inter processor commun=
ication
> stuff in one place, having an API that is made just exactly for that, ins=
tead
> of keeping to duplicate the IPI stuff over and over (and yes I know that =
for each
> remote processor the TX/RX is slightly different).
>
> If you aggregate the IPI messaging in one place, maintenance is going to =
be easier,
> and we stop getting duplication... more or less like it was done with the=
 mtk_scp
> IPI and mtk-vcodec .. and that's also something that is partially handled=
 as RPMSG
> because, well, it is a remote processor messaging driver.
>
> Just to make people understand *how heavily* MediaTek SoCs rely on IPI, t=
here's
> a *partial* list of SoC IPs that use IPI communcation:
>
> thermal, ccu, ccd, tinysys, vcp, atsp, sspm, slbc, mcupm, npu, mvpu, aps,=
 mdla,
> qos, audio, cm_mgr.... and... again, it's a partial list!

Indeed, the newest chip has become quite complicated.

> That said... any other opinion from anyone else?

I tried to describe why I thought a virtual mailbox was better.


Thanks
ChenYu

> Cheers,
> Angelo
>
> > Example of send and recve table:
> > Operation | mbox_id | ipi_id | msg_size | align_size | slot_ofs | pin_i=
ndex |  notes
> > send          0          0       18          18           0          0
> > recv          0          1       18          18          18          9
> > send          1         15        8           8           0          0
> > send          1         16       18          18           8          4
> > send          1          9        2           2          26         13
> > recv          1         15        8           8          28         14 =
      ack of send ipi_id=3D15
> > recv          1         17       18          18          36         18
> > recv          1         10        2           2          54         27 =
      ack of send ipi_id=3D2
> > send          2         11       18          18           0          0
> > send          2          2        2           2          18          9
> > send          2          3        3           4          20         10
> > send          2         32        2           2          24         12
> > recv          2         12       18          18          26         13
> > recv          2          5        1           2          44         22
> > recv          2          2        1           2          46         23
> >
> > Recv ipi_id=3D2 is the ack of send ipi_id=3D2(The ipi_id=3D15 is the sa=
me.)
> >
> > Jjian Zhou (3):
> >    mailbox: mediatek: Add mtk-vcp-mailbox driver
> >    firmware: mediatek: Add vcp ipc protocol interface
> >    dt-bindings: mailbox: mtk,vcp-mbox: add mtk vcp-mbox document
> >
> >   .../bindings/mailbox/mtk,mt8196-vcp-mbox.yaml |  49 ++
> >   drivers/firmware/Kconfig                      |   9 +
> >   drivers/firmware/Makefile                     |   1 +
> >   drivers/firmware/mtk-vcp-ipc.c                | 481 +++++++++++++++++=
+
> >   drivers/mailbox/Kconfig                       |   9 +
> >   drivers/mailbox/Makefile                      |   2 +
> >   drivers/mailbox/mtk-vcp-mailbox.c             | 179 +++++++
> >   include/linux/firmware/mediatek/mtk-vcp-ipc.h | 151 ++++++
> >   include/linux/mailbox/mtk-vcp-mailbox.h       |  34 ++
> >   9 files changed, 915 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/mailbox/mtk,mt81=
96-vcp-mbox.yaml
> >   create mode 100644 drivers/firmware/mtk-vcp-ipc.c
> >   create mode 100644 drivers/mailbox/mtk-vcp-mailbox.c
> >   create mode 100644 include/linux/firmware/mediatek/mtk-vcp-ipc.h
> >   create mode 100644 include/linux/mailbox/mtk-vcp-mailbox.h
> >
>
>
>

