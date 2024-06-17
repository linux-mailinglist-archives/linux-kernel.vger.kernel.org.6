Return-Path: <linux-kernel+bounces-217995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A81F90B789
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C4F1F2252E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A69C16A946;
	Mon, 17 Jun 2024 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="Ncp6BMIZ"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234F816A93C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718644319; cv=none; b=IhcZBsn+A3qjGPCi8ZRKPopczAH5hvwoovdc8P67WjiXAAG9dC/B6fPvJ2aZ8LPMIv4EHQ26Jjn1DiMPKzPNrSJSNSLrJgwGu3RZRMOo+z5YWsZMhejQ+AIV+4zb35Mc2IFVAU1xqwBOys6y3TEC2Qq22s/3jeEipFPRvo7+tYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718644319; c=relaxed/simple;
	bh=bQfLNhr0U8kTl1L3wYkkfLY24a4W+lf/0ASZXstjAi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JA36G/c9YS4LJcWznJqwpX7jo1HYiiZcMx9etiUMFeo5Z10qSjxJv/ecJE+OmkLkydiukojzA/5R6EJr/MPLv5qQyM6KW+tke9eNQJ7UUxNn5WkAxwMSHmz874JeLgm/9Z2RCt5aQatu1807qpvE4UsZfzk2xUcBdcVQqPpwKEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=Ncp6BMIZ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f4603237e0so3240890b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 10:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718644317; x=1719249117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zvckpjEpH2uOs9aOOdBydw6yHWYMDuUzMnQ/KJxhXX4=;
        b=YtUbEckC+4aLNweGMGvrxG8eMdBMwxvHL2hM5KakDYVJLcgdD3ZKVFtsD0VQP2hn7R
         Aybh1OTFs86wawDG5lBz0+X3/XF9clMU9nLx0iZuz31WXl8vfnoY1FRzr4jNmAOIWbHT
         RWJnNlHijtB3QjknS4T/wYDvirIO3IoLOW5K2XYmdtvgyBUHVra36r+91Kxv0UNEkQN0
         /a3MeQz9lE5IX7zTcziX24xOuqVSnlO6+yWCLy6w20z7Dt8gSztBjXk8cewkDHKvULyk
         oQd289g4t9IbTOJw86eSxy+mh/R3ubh9cgUAsoiEQ98q7EZodkFKJVIvRFGkdP3dut3T
         0koA==
X-Forwarded-Encrypted: i=1; AJvYcCU5Yv2QytHXWyqcUjIvscrZT9KY15Rdq7ptBTJ/Akqa4OP9pTVs/xezKvlYeXoSdxXZlTi9FTUFPFtCRgLYMDRZslAjDd1KOndS9HGe
X-Gm-Message-State: AOJu0YzboENPqrxv72ZWtSbT66d4FNPdzhDOx+1XkelR7W7TVrU+n2S8
	kINe2K/J1q/b92UPOCq7fAiSMrlrJFOg+bPIh4BNN1zX/qc26egD
X-Google-Smtp-Source: AGHT+IEpvx8oDxNqkEou9rQn23Am6pdR4u+cNRu+ZkVqeFYhca1Fq1ymn/C7x9An3U9SJF9ZufUo0A==
X-Received: by 2002:a05:6a00:9297:b0:6ed:de70:5ef9 with SMTP id d2e1a72fcca58-7061a9c528emr501333b3a.0.1718644316219;
        Mon, 17 Jun 2024 10:11:56 -0700 (PDT)
Received: from mail.marliere.net (marliere.net. [24.199.118.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc96868dsm7565177b3a.65.2024.06.17.10.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 10:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marliere.net; s=2024;
	t=1718644314; bh=bQfLNhr0U8kTl1L3wYkkfLY24a4W+lf/0ASZXstjAi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ncp6BMIZ4pWzzQA+l0B603lgqLVX7ZHa6cr6gTLjZhzo82zVWEorL/qvIBIaCplYe
	 2a3NWK4xv63+zEk7fqibpS2L8wlh5KHpGgdA1Vc/5xEbJ7Dt/00uOFfZeyl9R4Udxe
	 rYGGRcQMT0C07ZtEwDMjdH3XCx62xmyYS+9CFJn01QochRzZg+gA2YXeTz58mbwg/y
	 9GDT5ZQUJVEblnN8K6GnPcO4VLAiNjqnpzR7c1it3E1NsFSg5OdAzvZX4wAVxvdLLz
	 M8o/JfRlBS7szPz4zQNqE4BGs1N9l1YfCdxJvT6TgLB/Ren/h1b0+9QGnIcEukAqPw
	 jR3Tc1Udee1sQ==
Date: Mon, 17 Jun 2024 14:11:48 -0300
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Amit Vadhavana <av2082000@gmail.com>
Cc: srinivas.kandagatla@linaro.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, rbmarliere@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] slimbus: Fix struct and documentation alignment in
 stream.c
Message-ID: <d6cd7441-53f2-4c88-a361-729e3abe81c1@marliere.net>
References: <20240616203231.43724-1-av2082000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616203231.43724-1-av2082000@gmail.com>

On 17 Jun 24 02:02, Amit Vadhavana wrote:
> The placement of the `segdist_codes` array documentation was corrected
> to conform with kernel documentation guidelines. The `@segdist_codes`
> was placed incorrectly within the struct `segdist_code` documentation
> block, which led to a potential misinterpretation of the code structure.
> 
> The `segdist_codes` array documentation was moved outside the struct
> block, and a separate comment block was provided for it. This change
> ensures that clarity and proper alignment with kernel documentation
> standards are maintained.
> 
> A kernel-doc warning was addressed:
>     ./drivers/slimbus/stream.c:49: warning: Excess struct member 'segdist_codes' description in 'segdist_code'
> 
> Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
> ---
> Changes in v2:
>     - Removed `static const` keyword from `segdist_code` structure declaration.
> 
>  drivers/slimbus/stream.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/slimbus/stream.c b/drivers/slimbus/stream.c
> index 1d6b38657917..863ab3075d7e 100644
> --- a/drivers/slimbus/stream.c
> +++ b/drivers/slimbus/stream.c
> @@ -18,15 +18,17 @@
>   *		and the first slot of the next  consecutive Segment.
>   * @segdist_code: Segment Distribution Code SD[11:0]
>   * @seg_offset_mask: Segment offset mask in SD[11:0]
> - * @segdist_codes: List of all possible Segmet Distribution codes.
>   */
> -static const struct segdist_code {
> +struct segdist_code {
>  	int ratem;
>  	int seg_interval;
>  	int segdist_code;
>  	u32 seg_offset_mask;
>  
> -} segdist_codes[] = {
> +};
> +
> +/* segdist_codes - List of all possible Segment Distribution codes. */
      ^ isn't a '@' character missing here?

Make sure to re-build the docs and see whether it looks fine.

Thanks,
-	Ricardo.



> +static const struct segdist_code segdist_codes[] = {
>  	{1,	1536,	0x200,	 0xdff},
>  	{2,	768,	0x100,	 0xcff},
>  	{4,	384,	0x080,	 0xc7f},
> -- 
> 2.25.1
> 
> 

