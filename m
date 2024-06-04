Return-Path: <linux-kernel+bounces-201015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 936CB8FB82B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4905A1F22C76
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A215145B09;
	Tue,  4 Jun 2024 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BNod94XJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF675946C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516472; cv=none; b=aRh3NkBnA2qnYp7FCmtNwz5QQJw1R2IHeO2aP4mzvj6+Xgq+3JLUCji1Up7tsMWuZrszXAjbA/psMMJ9qp1WGewXPBdd/IG3zVkc7S2M0v0SPW03ht3FH/ecIFZ6VKIA8GBm7mEZi8KSMqQoISHMjn9oJEUuUldXsO4sFHmG5xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516472; c=relaxed/simple;
	bh=pN9UH5Mgl6rogQEhBrUTMDaicXknjjwunkhQGsXjFnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niKX/uXK9kks1ix8hmsdX3ijpK3K8M2gqT0Us+Jd9h8Bl/zBPp4KsvAYc7CyVh7Z22rG7Hald0cdITa0rEfdlxelqiGeI0OeEgulu+0mKyV6axF+XtDRlOetIanbFjjwhf5siQqC1klTfVKVD+jUrsChdqEaf/JbwM+/u8Ury+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BNod94XJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87472C2BBFC;
	Tue,  4 Jun 2024 15:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717516472;
	bh=pN9UH5Mgl6rogQEhBrUTMDaicXknjjwunkhQGsXjFnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BNod94XJLOLZKAvkR9aGZF4eA+WrPBhblN1Aba4TSN5nfd+2D8/K5qlOqsIu0vjMG
	 s422+vL679m3pq8SsBlOfgEJK6pq8/ekxh+c5R5KHz4eTQOUDXXL/l6+fGPb4Le0us
	 F7j0U5rP6xY/zxJ66ds7vzfCN/6uDv4Jl2vzX7Zw=
Date: Tue, 4 Jun 2024 17:52:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vamsi Attunuru <vattunuru@marvell.com>
Cc: jerinj@marvell.com, schalla@marvell.com, arnd@arndb.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/1] misc: mrvl-cn10k-dpi: add Octeon CN10K DPI
 administrative driver
Message-ID: <2024060412-amulet-unflawed-f37a@gregkh>
References: <2024042950-refurbish-duckbill-77b4@gregkh>
 <20240520110630.2568767-1-vattunuru@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520110630.2568767-1-vattunuru@marvell.com>

On Mon, May 20, 2024 at 04:06:30AM -0700, Vamsi Attunuru wrote:
> +union dpi_mbox_message {
> +	u64 word[2];
> +	struct {
> +#if defined(__BIG_ENDIAN_BITFIELD)
> +		/* SSO PF function */
> +		u64 sso_pf_func  :16;
> +		/* Aura of the command buffer */
> +		u64 aura         :20;
> +		/* Command buffer size in 8-byte words */
> +		u64 csize        :16;
> +		/* Command code */
> +		u64 cmd          :4;
> +		/* VF ID to configure */
> +		u64 vfid         :8;
> +		/* Reserved for future use */
> +		u64 rsvd_85_127  :40;
> +		/* Work queue completion status byte offset */
> +		u64 wqecsoff     :7;
> +		/* Work queue completion status enable */
> +		u64 wqecs        :1;
> +		/* NPA PF function */
> +		u64 npa_pf_func  :16;
> +#else
> +		/* VF ID to configure */
> +		u64 vfid         :8;
> +		/* Command code */
> +		u64 cmd          :4;
> +		/* Command buffer size in 8-byte words */
> +		u64 csize        :16;
> +		/* Aura of the command buffer */
> +		u64 aura         :20;
> +		/* SSO PF function */
> +		u64 sso_pf_func  :16;
> +		/* NPA PF function */
> +		u64 npa_pf_func  :16;
> +		/* Work queue completion status enable */
> +		u64 wqecs        :1;
> +		/* Work queue completion status byte offset */
> +		u64 wqecsoff     :7;
> +		/* Reserved for future use */
> +		u64 rsvd_85_127  :40;
> +#endif
> +	};
> +};

The ifdef is cute, but not correct, sorry.  Please use bit shifts to
handle this properly without any #ifdef needed at all.




> +
> +static inline void dpi_reg_write(struct dpipf *dpi, u64 offset, u64 val)
> +{
> +	writeq(val, dpi->reg_base + offset);

No read needed after a write to ensure the write made it to the hardware
properly?

thanks,

greg k-h

