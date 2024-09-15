Return-Path: <linux-kernel+bounces-329887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA4997971F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 16:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E974A1F2175F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 14:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72F61C7B90;
	Sun, 15 Sep 2024 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qrator.net header.i=@qrator.net header.b="E3Cqre1y"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EED11E511
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726410597; cv=none; b=hKeXzMB8+jSkW9iFKFwWeIo5KNMmPLujCR3jgpygChbfpNeX2623z3W3c130nIyhnfKHfWML8KLoQmfrp3JnmCrXSh7NvqEUC5NMoL5zzvi7AqdqYuOGAZo+deGgX2hyR2NMeOQLJ4T0Za9UEnHnEYsoha4PGbapCNT9wPjUYHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726410597; c=relaxed/simple;
	bh=fDwZmtc//P2Q2CdWV3iL8VGYYtZ7Lfy4KE3dIScwPWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yl/GGODfnEv6bwd68wwTLz22kJ4vXq2BD0Xdxh/I1uPTaHRzp7wt7qKB2Ii51/UZThrZRgBuJ7yzf7GPsuGiEelwSLTe0VbjI6kvXRGHT3fJp2nBBOLFXt+qbeKQokCnFCDyqb6zezdUNFWRDxdVQO3SjIdgz2MJ+4OIkndHB4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net; spf=pass smtp.mailfrom=qrator.net; dkim=pass (1024-bit key) header.d=qrator.net header.i=@qrator.net header.b=E3Cqre1y; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qrator.net
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7d82b0ebd51so732659a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 07:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qrator.net; s=google; t=1726410593; x=1727015393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiN1biVjfblfJCNoQE1Fqe/UWwPtym8JKqZfHUuB314=;
        b=E3Cqre1yODiQc1glrsFIamYw5clN7O4XJTuNIwr1eZ7z9oU0dYxGv9Ip84rjdEw1g/
         X1ZbL2GJzyCXofP73mYXd8WAn6ndIhVYff8K4vuE91l7vKWYbHIE1OGVHL/a0Nv62EOs
         4HxzQO7HVHS43AjCIGXXVjUR3PW4ClBOor6H4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726410593; x=1727015393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiN1biVjfblfJCNoQE1Fqe/UWwPtym8JKqZfHUuB314=;
        b=qpthyOI6VZuY17z0bbucHXve60uQIDkqjoAyrmD+wTkFVmN5l5kmihmaPkcBh/o2F9
         ziQXUu+0AhvBhvwEKqbKcBVPvbzdjrrVttVvLYpNcAm50WwMt6Hk2dmXY8yZnRGnMEgh
         E2FYpOodJwk3/nUWP9iPmYX2P1Yas4TyNloR7y2LswKyHoVRenVBC7HSE2D28ImlrNbG
         KvIr7NghYOmDWyKfgwEwdg+AJqjuPKBnshc4cxA59Qn12t0SI9aSYOdhn0eHv/SvRSWC
         0G8ERePHpNITAJ8n8cLoj1j4j9P/FpAEik+y2p7lc1ZGnfJma1npWXfpDDu8n+xuehqz
         zQUA==
X-Forwarded-Encrypted: i=1; AJvYcCWXQKw/5GnsE/sVaZC18kKl66ngt4NDDFsnk6cy8ojKNDFLIMsqK0RMcMQdUvEDMRUSWRiY8/R8u2Dt5y8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu+J6+lebrVdjOIKb8SQqFqdylRiStGt3jhnHRtAxsddkSDCl1
	Z/WdS1kYN29Nv/ND8DtDB0vcGUQ0twk7iUDCZPPG6z0o1+BYzD7i+q2TwMbSVXdTpTwU9adLpt8
	282c1UEmV99gcJ17iY78BM5Fvc6FhUSMLVHYnzrgg98njx4CctokPdQ==
X-Google-Smtp-Source: AGHT+IEmTfcSy2BdcoIbFnHj7Jr0iZmswWCzXnNS3Vc74mJiumfaNvb3/VQsIXzgYHEgrmdiu+CwlJ2gQc7qP9zyBkE=
X-Received: by 2002:a17:90b:1806:b0:2d8:f12f:6bed with SMTP id
 98e67ed59e1d1-2dbb9dc122emr11056192a91.3.1726410593238; Sun, 15 Sep 2024
 07:29:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240622164013.24488-2-green@qrator.net> <Zncwl4DAwTQL0YDl@gallifrey>
In-Reply-To: <Zncwl4DAwTQL0YDl@gallifrey>
From: Alexander Zubkov <green@qrator.net>
Date: Sun, 15 Sep 2024 16:29:26 +0200
Message-ID: <CABr+u0b-RAV9hz25O5a3Axz6s9vYLVc5shr8xAgPsykP_XRFgw@mail.gmail.com>
Subject: Re: [PATCH] Fix misspelling of "accept*"
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	linux-newbie@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I just wanted to kindly check in on the status of my patch. Please let
me know if any further action is needed from my side.

Thanks for your time!

Best regards,
Alexander Zubkov

On Sat, Jun 22, 2024 at 10:14=E2=80=AFPM Dr. David Alan Gilbert
<linux@treblig.org> wrote:
>
> * Alexander Zubkov (green@qrator.net) wrote:
> > Several files have "accept*" misspelled as "accpet*" in the comments.
> > Fix all such occurrences.
> >
> > Signed-off-by: Alexander Zubkov <green@qrator.net>
>
> Reviewed-by: Dr. David Alan Gilbert <linux@treblig.org>
>
> hmm, should probably cc in some maintainers, I guess networking.
> (added netdev and Paolo)
>
> Dave
>
> > ---
> >  drivers/infiniband/hw/irdma/cm.c                              | 2 +-
> >  drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c | 4 ++--
> >  drivers/net/ethernet/natsemi/ns83820.c                        | 2 +-
> >  include/uapi/linux/udp.h                                      | 2 +-
> >  4 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/i=
rdma/cm.c
> > index 36bb7e5ce..ce8d821bd 100644
> > --- a/drivers/infiniband/hw/irdma/cm.c
> > +++ b/drivers/infiniband/hw/irdma/cm.c
> > @@ -3631,7 +3631,7 @@ void irdma_free_lsmm_rsrc(struct irdma_qp *iwqp)
> >  /**
> >   * irdma_accept - registered call for connection to be accepted
> >   * @cm_id: cm information for passive connection
> > - * @conn_param: accpet parameters
> > + * @conn_param: accept parameters
> >   */
> >  int irdma_accept(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn=
_param)
> >  {
> > diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_mai=
n.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
> > index 455a54708..96fd31d75 100644
> > --- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
> > +++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
> > @@ -342,8 +342,8 @@ static struct sk_buff *copy_gl_to_skb_pkt(const str=
uct pkt_gl *gl,
> >  {
> >       struct sk_buff *skb;
> >
> > -     /* Allocate space for cpl_pass_accpet_req which will be synthesiz=
ed by
> > -      * driver. Once driver synthesizes cpl_pass_accpet_req the skb wi=
ll go
> > +     /* Allocate space for cpl_pass_accept_req which will be synthesiz=
ed by
> > +      * driver. Once driver synthesizes cpl_pass_accept_req the skb wi=
ll go
> >        * through the regular cpl_pass_accept_req processing in TOM.
> >        */
> >       skb =3D alloc_skb(gl->tot_len + sizeof(struct cpl_pass_accept_req=
)
> > diff --git a/drivers/net/ethernet/natsemi/ns83820.c b/drivers/net/ether=
net/natsemi/ns83820.c
> > index 998586872..bea969dfa 100644
> > --- a/drivers/net/ethernet/natsemi/ns83820.c
> > +++ b/drivers/net/ethernet/natsemi/ns83820.c
> > @@ -2090,7 +2090,7 @@ static int ns83820_init_one(struct pci_dev *pci_d=
ev,
> >        */
> >       /* Ramit : 1024 DMA is not a good idea, it ends up banging
> >        * some DELL and COMPAQ SMP systems
> > -      * Turn on ALP, only we are accpeting Jumbo Packets */
> > +      * Turn on ALP, only we are accepting Jumbo Packets */
> >       writel(RXCFG_AEP | RXCFG_ARP | RXCFG_AIRL | RXCFG_RX_FD
> >               | RXCFG_STRIPCRC
> >               //| RXCFG_ALP
> > diff --git a/include/uapi/linux/udp.h b/include/uapi/linux/udp.h
> > index 1a0fe8b15..d85d671de 100644
> > --- a/include/uapi/linux/udp.h
> > +++ b/include/uapi/linux/udp.h
> > @@ -31,7 +31,7 @@ struct udphdr {
> >  #define UDP_CORK     1       /* Never send partially complete segments=
 */
> >  #define UDP_ENCAP    100     /* Set the socket to accept encapsulated =
packets */
> >  #define UDP_NO_CHECK6_TX 101 /* Disable sending checksum for UDP6X */
> > -#define UDP_NO_CHECK6_RX 102 /* Disable accpeting checksum for UDP6 */
> > +#define UDP_NO_CHECK6_RX 102 /* Disable accepting checksum for UDP6 */
> >  #define UDP_SEGMENT  103     /* Set GSO segmentation size */
> >  #define UDP_GRO              104     /* This socket can receive UDP GR=
O packets */
> >
> > --
> > 2.45.2
> >
> >
> --
>  -----Open up your eyes, open up your mind, open up your code -------
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/

