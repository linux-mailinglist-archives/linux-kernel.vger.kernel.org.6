Return-Path: <linux-kernel+bounces-219604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D2E90D692
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DB39B2106F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB32A15B15F;
	Tue, 18 Jun 2024 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="m7Jr6evo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VHY0FzRV"
Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2714415B144
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720390; cv=none; b=C+SmqavLwm/tSwGDsQcXiPCTQrJohkCLkQCDaNswCsv2HXNC5fqQUqyf1sJDlF23IXkryNTF2Z6UEOXo8o5PpErC8LA8Ys5klr0UUTXrBOPtLZFm29AtpbLmzio5rXNWfz0FuzgUiA+9h4J6uPplZ0OGoWpBflTD1i1qU6en7yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720390; c=relaxed/simple;
	bh=BIh9OzW2RLrH0uPur/FPnzv1KfDkFhKIXwKQoCn//TI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=oUcB2Ozt4M3iy8TGYHA/zc1WaTYKCre6zQZSTfboDiUaTEcHNYdNwNPq6FrfttscW/LFJInUThIC/bJSFlo1xq6TWIoGihFOno4bOsbfnejF5Yu3v0U0tI/oPmZU0rQxa7cP79LmNwgBqC1zjI2Gcw46ulZrKCOvH30wSgYtCIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=m7Jr6evo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VHY0FzRV; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 0226018000F6;
	Tue, 18 Jun 2024 10:19:46 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 18 Jun 2024 10:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718720386; x=1718806786; bh=rwcVLDKs+b
	+ginYZXxz0DN+xa2bE39ELE5KcARG0DJs=; b=m7Jr6evoR/SIAQDdn3AC5FGv0j
	c60giKuGWPVIRBVIIXHF57fR0ZlsdNO9ISQKZoAH1d5E3jCZb2j5kexWtwfHzLjO
	2jgPg11R+NZs3o1HB9xDI15BNRE8ZiSQoRgSfXNwRjzgjs3aFJtbPr1nsAqKSb3p
	7tKEfjGFBFvn6iQkEOYPpUqU+eFLukcva6x6tFg2ySHvIwWvphANs9qzRNQT3BrH
	KKaNBJhdnI3R9cVNDUtlU5iLuFJIlh4JtUOF9pmdU/LWYbICGnrnRjTw05Uq+7qt
	Jx3/VSypjK6+srloTRy4ejbmasimaOQeXzyzDgeMItx4I0ui0hsqzRV5zqtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1718720386; x=1718806786; bh=rwcVLDKs+b+ginYZXxz0DN+xa2bE
	39ELE5KcARG0DJs=; b=VHY0FzRVf6UE9fG2pmhiKfoFkhF8u3o08Fby1g/qT0Tp
	FotD1Oj8ZnwMToUufx1jGATGTnJj6SKnqU7JznCGRsNjbsY2QrZp1rCR/rPV3Bte
	CV5oggN8qKSXKqzGgvMSg8w2rwSZFQCz+CwwDId8Zc2snR5JJxDe8ZxmfZKEzSbL
	5R6xjnTOnKeUhPVWXQ+h+CQd5eRHuvqs8xdNw/yZ+aV9QIXYUxr3rlniWV7eKZX5
	hst+kdkpdHDzm3rSW88SQ1P+d4ziyTHG+W+HmjdZrMNghi8/EWHVO/G1Wnrv5VgQ
	0pK6KequrPoFvNMi87VDEK9dLIElpMU+76kkHtLhqA==
X-ME-Sender: <xms:gpdxZmbbO0191sA-9uYPDnbUxXeaYzfSiNLL6sCBzxxzz_KwLdtarA>
    <xme:gpdxZpYqmKcRa5bjTGfusm4l-J2xy4317z1ABmdFxzob9Cq7scBkk6Q1FHJaK_xft
    77M5P9uL57QkZcJuJo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvkedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:gpdxZg8-tV93qtNBrC-RGn7PlIGuxUac85ZMum8hsLPb92ax2hUyQQ>
    <xmx:gpdxZopSpBJyFI82dbgDfyy1RaQ89s4qQKlEo4cKMFA2JozvDHiZXQ>
    <xmx:gpdxZhrlmpE_u66kAWOy0QyJ2UK6pxK-8XgbrXWUxC9EQCiSak-3Ow>
    <xmx:gpdxZmSEp2mNcNMU7b8N2IJK3EhzyRXjgAVleiTV7TYAJt6NHw_qiw>
    <xmx:gpdxZimAZ0cHud7yID5oiBblsyWZ3NGwmvxkejaLHjtKjzYoEaD2mb_Z>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4DBB3B60092; Tue, 18 Jun 2024 10:19:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c43e2c24-cd5b-44c2-a997-5f324f58746c@app.fastmail.com>
In-Reply-To: <20240618130937.3070993-1-vattunuru@marvell.com>
References: <2024060412-amulet-unflawed-f37a@gregkh>
 <20240618130937.3070993-1-vattunuru@marvell.com>
Date: Tue, 18 Jun 2024 16:19:25 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Vamsi Attunuru" <vattunuru@marvell.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: "Jerin Jacob" <jerinj@marvell.com>,
 "Srujana Challa" <schalla@marvell.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/1] misc: mrvl-cn10k-dpi: add Octeon CN10K DPI administrative
 driver
Content-Type: text/plain

On Tue, Jun 18, 2024, at 15:09, Vamsi Attunuru wrote:
>Changes V7 -> V8:
> - Used bit shift operations to access mbox msg fields
> - Removed bitfields in mailbox msg structure

Thanks for the changes, looks good to me. Two more things:

> +static void dpi_poll_pfvf_mbox(struct dpipf *dpi)
> +{
> +	u64 reg;
> +	u32 vf;
> +
> +	reg = dpi_reg_read(dpi, DPI_MBOX_VF_PF_INT);
> +	if (reg) {
> +		for (vf = 0; vf < pci_num_vf(dpi->pdev); vf++) {
> +			if (reg & BIT_ULL(vf))
> +				schedule_work(&dpi->mbox[vf]->work);
> +		}
> +		dpi_reg_write(dpi, DPI_MBOX_VF_PF_INT, reg);
> +	}
> +}
> +
> +static irqreturn_t dpi_mbox_intr_handler(int irq, void *data)
> +{
> +	struct dpipf *dpi = data;
> +
> +	dpi_poll_pfvf_mbox(dpi);
> +
> +	return IRQ_HANDLED;
> +}

[minor cleanup]
The second function doesn't do much here, so you could
just merge them into one. Or to simplify it further, you
could just use request_threaded_irq() and avoid the separate
workqueue as well.

> +struct dpi_mps_mrrs_cfg {
> +	__u16 max_read_req_sz; /* Max read request size */
> +	__u16 max_payload_sz;  /* Max payload size */
> +	__u8 port; /* Ebus port */
> +};
> +
> +struct dpi_engine_cfg {
> +	__u64 fifo_mask; /* FIFO size mask in KBytes */
> +	__u16 molr[DPI_MAX_ENGINES]; /* Max outstanding load requests */
> +	__u8 update_molr; /* '1' to update engine MOLR */
> +};

Both of these structures have architecture specific padding
at the end because the members don't add up to a multiple
of words. Please add explicit reserved fields to a multiple of
8 bytes for each one, or make the fields longer.

Documentation/driver-api/ioctl.rst has more details on this.

     Arnd

