Return-Path: <linux-kernel+bounces-363305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DA199C03E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9136B2139A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0287213CFA1;
	Mon, 14 Oct 2024 06:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8zh6oMR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57FC1171C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728888510; cv=none; b=n873w40he/7hXYbpCBtNB/h2GHYCXmFptwmaDjDLpPDJ+ytDzcT5IrEk57MLPEGdmRlI46yPbK5PbJfvWVKZEPUY6sC0WYhkZzO8Jp/PfZmyqw35N6Sd3n6vyJrNzasktQE7BAThpArHO/GZufVfK8xocTLXD8NyLneT5a0zlWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728888510; c=relaxed/simple;
	bh=TWLY8gFXi6zZrdCtsmsuGezKS4Vv9L373qHibuel/Dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iO4vtkdtLY6km3VdDKHcjK5SHEtnwSbMmoVy6a16tcDZlBMDGo4VJsqB5KYfdbpzA8cwOYI19EUhD0hjjer/H242PSAyCjsbSycZUHIcTQrSaud0wVTLmJEIqRF6Ukfk4/9skccxi6MNsvT+iQR1ouxVAPebnm9FpXQrzH0kYuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H8zh6oMR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728888507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TWLY8gFXi6zZrdCtsmsuGezKS4Vv9L373qHibuel/Dg=;
	b=H8zh6oMRanBRZGoKWwMFGF2VI6U+JNeMJKeTdBN/eNIkCELqwBumaCxI5sY673heRAwnVs
	WBLq1cYCejIZ0pn8iZvk0wr36jIlQzYrKklNcH8JKWqCpTT3Nzb5/LXNdmx11RX0eimqEe
	Rf8mOb4ej6aFVeBUMTiF9GWJJj0onBs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-otJRjR8pMPq315HrGArifg-1; Mon, 14 Oct 2024 02:48:26 -0400
X-MC-Unique: otJRjR8pMPq315HrGArifg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a995056fadcso246883966b.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 23:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728888505; x=1729493305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWLY8gFXi6zZrdCtsmsuGezKS4Vv9L373qHibuel/Dg=;
        b=TGxq8OsDGi+uCjKvBJnlaLmrm3p9QtulN/OxKmvnc8+NtkJJgl5owFhTgnC1rnHRM8
         80aDRvkXNvFbKlfOTvKGh2pCXPgtjazaJH26PxSwcBwhXcnvlni4iL0PNEA8PkC49Hww
         ND9313do8VXYyo5yrGloQHHY06VtD6ROps+KVdW98SbYxwrTwQkRttwv7xf0TZjTylKq
         L+rChEjJ709pDWjSy1UeAhP3LiDw8k/udUL1LBl17zRme1Y8jTqsnJZ7bX+lZT8tOWy0
         kjwCZ328JoVtdDtwfZmO67VDHBqwpwj2rPzXkJ9qF4BDRH8UGHe0eDKIgiU2LFCDuYep
         ko1w==
X-Forwarded-Encrypted: i=1; AJvYcCVbqikcmIpM4dtxplrkHZVBkRunh/43hq4shm+UzPlQYHMvxHExVLiACMHoJuBFvWxPbxp9StKuc+vtahU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTsMR1ASRq142cVksRAcde+EpGEVcmo6papLk5EXQ3dTrGbtUz
	XXPv3yj+yWPVZ1qsIP7dAinoz+7PsXBysnJOUXK3D2eqeZWerLuXv4ZpVvuuj8ZxIZVEEHpaB/T
	pvvTCJq2L++kRyvzoyjMpUQOzRoc95XzMOM/FhSH9SbUdnDzOTCkoKcxdHpuGeoZgD2+XPrspY2
	NuhWm16uL49Qq5C+MD5CP+2e6HelS5klEpNk0e
X-Received: by 2002:a17:907:7288:b0:a99:5601:7dc1 with SMTP id a640c23a62f3a-a99b9586a29mr857240566b.49.1728888504951;
        Sun, 13 Oct 2024 23:48:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDZvvo05EHXZwdjWpt7gfBXCGbv70zK4KousTsCTsR0Vs+Ov9GRND0pLhhxGNdC5rR0lauK8au+RVOPzggu5s=
X-Received: by 2002:a17:907:7288:b0:a99:5601:7dc1 with SMTP id
 a640c23a62f3a-a99b9586a29mr857239266b.49.1728888504617; Sun, 13 Oct 2024
 23:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004015937.2286459-1-lulu@redhat.com> <20241004015937.2286459-2-lulu@redhat.com>
 <olbm26f3ifb6ypfmfl22xszbpevqsxc3ogfzosrb44ujtzt6pw@uh7irbqfy5jr>
 <CACGkMEt-8hdiAaAPjNAPNSNtBFHK+ogCndHFJMtYpjEzoTK6Qg@mail.gmail.com>
 <d4h4g7txswidmpau5i6evvnragzzgtbxgoelorcolowweb4qjo@ujevaic3uzrv> <CACGkMEv+qfmuEnjjgbZc2nSKCN0TbwJvu6D1CiYV_zHw7QR46g@mail.gmail.com>
In-Reply-To: <CACGkMEv+qfmuEnjjgbZc2nSKCN0TbwJvu6D1CiYV_zHw7QR46g@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 14 Oct 2024 14:47:48 +0800
Message-ID: <CACLfguXTPkuS0fNZVJFq7KyByp_A4nCD2empyDUz+fYg1M2h0Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] vhost: Add a new modparam to allow userspace
 select vhost_task
To: Jason Wang <jasowang@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Oct 2024 at 16:20, Jason Wang <jasowang@redhat.com> wrote:
>
> On Wed, Oct 9, 2024 at 4:10=E2=80=AFPM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
> >
> > On Wed, Oct 09, 2024 at 03:28:19PM GMT, Jason Wang wrote:
> > >On Mon, Oct 7, 2024 at 9:31=E2=80=AFPM Stefano Garzarella <sgarzare@re=
dhat.com> wrote:
> > >>
> > >> On Fri, Oct 04, 2024 at 09:58:15AM GMT, Cindy Lu wrote:
> > >> >The vhost is now using vhost_task and working as a child of the own=
er thread.
> > >> >While this makes sense from containerization POV, some old userspac=
e is
> > >> >confused, as previously vhost not
> > >>
> > >> not what?
> > >>
> > >> > and so was allowed to steal cpu resources
> > >> >from outside the container. So we add the kthread API support back
> > >>
> > >> Sorry, but it's not clear the reason.
> > >>
> > >> I understand that we want to provide a way to bring back the previou=
s
> > >> behavior when we had kthreads, but why do we want that?
> > >> Do you have examples where the new mechanism is causing problems?
> > >>
> > >
> > >The main difference is whose (kthreadd or the owner) attributes
> > >(namespace, affinities) would vhost thread inherit.
> > >
> > >The owner's attributes tend to be different from kthreadd, so
> > >management might be surprised for example, vhost might be created in
> > >different namespaces or having different scheduling affinities.
> >
> > Okay, so this requires some API to allow the managment to understand ho=
w
> > the device vhost will be created.
> >
> > But why do we need to restore the old behavior with a kthread where the
> > resource accounting is completely disconnected from userspace?
> > For the old managments that don't expect this?
>
> Yes, as such change can be easily noticed by the user space that
> breaks existing management layers or tools.
>
> >
> > BTW I would suggest adding all this information in this commit, in the
> > parameter/IOCTL documentation, and in the cover letter because IMHO it
> > is very important.
>
> I've asked this in the past. Cindy, please make sure such information
> were included in the next version in the cover letter.
>
> Thanks
>
Thanks Jason, I will add this
Thanks
cindy
> >
> > Thanks,
> > Stefano
> >
>


