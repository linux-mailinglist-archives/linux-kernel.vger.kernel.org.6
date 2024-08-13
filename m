Return-Path: <linux-kernel+bounces-284477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ECA950168
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F011F23D40
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6BF17E919;
	Tue, 13 Aug 2024 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w5+b3lm8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F3817C7C2
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542114; cv=none; b=JZERpWjFLnvTReDv+rBabr/ClumiISFxBbJekJUrbB5rbFE0wD0LhjqaN4yF5ApaEWltZsW0/4V39WBGQxQsmF7WSlRCyzylTOHgAPHtcH4uZlCVD17rfypVBV9fhWQxEcJd56aGpM84c0PtpF4LWZTJVXnWP42farepIxxDdQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542114; c=relaxed/simple;
	bh=tzhK6m4voq98kYClzQDHV7AWqew7oBQ/+NqrY5LsO/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4TNuBLSOI8LrawXmugopLsoDKN6NNaFLIC4cN3SNEDEqC60OB7KLDC3ol8FoLM4nN5eDUF3mYSbQoQh4q1xv1dFuUEtpJp0zKhHAgjEDynaIYETnJaWp6lnooCvPZR4/1pD0ZfQub0PBF4CPyE7VyCmGIvFC7IA4sQ5K4q+yQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w5+b3lm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABE0C4AF0B;
	Tue, 13 Aug 2024 09:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723542113;
	bh=tzhK6m4voq98kYClzQDHV7AWqew7oBQ/+NqrY5LsO/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=w5+b3lm8L9SlPGkAcFRYZ3/DOOcyOCE6BJOdBouO21qbnXu6lo4P344ELmSe8VAzj
	 EOutuySH7VMBubt3/0ylEz7K6hpElgSnR/zxxOAdZcZLVdt6BqBCuTtOr/dMI5hbs9
	 VgFdjX6TEU0fo4Tgk5wnO5tmJRsvEE5oGfLwuPRQ=
Date: Tue, 13 Aug 2024 11:41:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v2] driver core: Simplify driver API
 device_find_child_by_name() implementation
Message-ID: <2024081330-posting-tapestry-9372@gregkh>
References: <20240811-simply_api_dfcbn-v2-1-d0398acdc366@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811-simply_api_dfcbn-v2-1-d0398acdc366@quicinc.com>

On Sun, Aug 11, 2024 at 01:49:58PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Simplify device_find_child_by_name() implementation by using existing
> driver APIs device_find_child() and device_match_name().
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> Changes in v2:
> - Correct commit message and remove all unnecessary comments and codes
> - Link to v1: https://lore.kernel.org/lkml/20240720-simplify_drv_api-v1-1-07c5e028cccf@quicinc.com
> ---
>  drivers/base/core.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index f152e0f8fb03..8ed593d7e0be 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4093,18 +4093,7 @@ EXPORT_SYMBOL_GPL(device_find_child);
>  struct device *device_find_child_by_name(struct device *parent,
>  					 const char *name)
>  {
> -	struct klist_iter i;
> -	struct device *child;
> -
> -	if (!parent)
> -		return NULL;
> -
> -	klist_iter_init(&parent->p->klist_children, &i);
> -	while ((child = next_device(&i)))
> -		if (sysfs_streq(dev_name(child), name) && get_device(child))
> -			break;
> -	klist_iter_exit(&i);
> -	return child;
> +	return device_find_child(parent, name, device_match_name);
>  }
>  EXPORT_SYMBOL_GPL(device_find_child_by_name);
>  
> 
> ---
> base-commit: bfa54a793ba77ef696755b66f3ac4ed00c7d1248
> change-id: 20240811-simply_api_dfcbn-eebeb153bec7
> prerequisite-change-id: 20240811-const_dfc_done-c5c206675c6b:v1
> prerequisite-patch-id: 475b810c1ccacab955c654c223d5214f70c4f6c8
> prerequisite-patch-id: 81a5ccaa144a7732cae29fc5ea1a13426becee5b
> prerequisite-patch-id: 9b77254186b7366809f949f5643f9437fa2528a0
> prerequisite-patch-id: 95308bb3eedcf8c4a5e30aa3071116148495329e
> prerequisite-patch-id: ee643a52674e2aead02f7be3d011d88507970436
> prerequisite-patch-id: 0625de1f03ef4350b1828f0faff7a9d9bdebae94
> prerequisite-patch-id: 6e671f2891f6ed906a35e0a90b5d8cd71c382b9c
> prerequisite-patch-id: 8859b6fa330c363ef37567fc0a5421c0b9ecd8dc
> prerequisite-patch-id: fe9aa57807bbb8b98dba32abd614d8f2e27565cd
> prerequisite-patch-id: d03febd9c0afd5d21a2f664d748da7d7811a8e84
> prerequisite-patch-id: c7425de06cf7032d54ff72f610d7632941be976e
> prerequisite-patch-id: 54c942a1a492ba04480337f99dc901a8d4def782
> prerequisite-patch-id: 7e8f4a3e378d5329b886a9a3719add3cbb10e3e3
> prerequisite-patch-id: 34ff831994ac7bc265f567bacefff8ae687ccd40
> prerequisite-patch-id: 66d46c755c25065e9d440a4137e1e8ccc245e0be
> prerequisite-patch-id: 15bc81129ee07324b5a8faa39a5e6aea59952573
> prerequisite-patch-id: fe9ca6ae244761b48469f375fe1fc8c9c7b24204
> prerequisite-patch-id: a6fd24b37269a06a91fd926fa5111a19cdec7551
> prerequisite-patch-id: 2f584b03145bc7d01e3ea632c6abb89d3b543d93
> prerequisite-patch-id: 10e0d06e0340ce5028cd109fffa7f0720c70d242
> prerequisite-patch-id: 0f9ea4a7c63d15c5c1324c5666901f0704c129ca
> prerequisite-patch-id: 4f56ebd28ae00a50130f58409d934ca79ccec6a9
> prerequisite-patch-id: 70e7432951b43a67204bb7eb6c437ba135def0f1
> prerequisite-patch-id: 1718891e69e1d2031336b4a6e7f251c50619f336
> prerequisite-patch-id: 5f838fb00256dbadfd36735ef3a1b1e43ec20549
> prerequisite-patch-id: f4b36e4136d462c8ba9f94f777a6fa1a054b8809
> prerequisite-patch-id: 56c12ce5dc6bfb090fa7801fa3f31c4e52b50775
> prerequisite-patch-id: 2b23c8c2ae90030a59d267297b478584447b78ac
> prerequisite-patch-id: 294c325d517e318063c61af218607d9721f1cc5f
> prerequisite-patch-id: 38fb282ac119a88af58a88b38c9cdc74372df404
> prerequisite-patch-id: d3ab2693194b77403d6ce20edf25ee3896d0260b
> prerequisite-patch-id: 19b69184800129923777ee2acd2629565c69291b
> prerequisite-patch-id: f58374cebf0ada070fc0825736424dd177e49676

As those ids are not going to be in my tree (or anyone else's), how are
we supposed to apply this?

confused,

greg k-h

