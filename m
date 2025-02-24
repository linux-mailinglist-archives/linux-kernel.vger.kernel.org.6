Return-Path: <linux-kernel+bounces-530202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64839A4307B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A1E3B87FD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB0C1E1C2B;
	Mon, 24 Feb 2025 23:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jw9aBPxn"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666094430
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 23:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740438205; cv=none; b=WGoC/RkbDLykDorYOScvOeNeAyPPn7PpcGXiQTfD773lsEop+LnX77rewemHf21L+Md0hZVLY9P0WEN9ZUDR5LFg8EOgvoi1pMS2J1A2nEgX9dLE4eMYkjd1o58by2aRZbRYkIH1qXkv9sMPWCR5JwjLy7zmoTdKHqsrZYFRHs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740438205; c=relaxed/simple;
	bh=bw+PNOlqBxg6SccFf9SOtcWrtuDmMg5yoZO34vtTFMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8JoiAQMprNuMuOzxzFg/IqjzNeLlBqYMZox7llfuewoRTDo0P8+7Lse9u/w0LO0UbCphYt1jwnceW0P9P1O249w3azwdwwVUafDGQJDCBSJ7r3bz9lkS8DVZSRf6w7T4YTMDI8Vufqex92Q7kTcSTTSoBBRrpoLPAhzr+PZUaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jw9aBPxn; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sv7NBBUK0iR17+DT1muJAlxLgMMcN2uOXWyR5DIoeRg=; b=jw9aBPxnpgajuAgS7W/f3eeGjf
	rk9SbNMSDilEMWynXPdU8RPaEPIhYUV0zRUqwbIddDHUyZqvgg2f1NOFaPSdnJ9ANb4pKhdCJE8+I
	WRiEVR+1pvUULwS+fVhKl1fZJP1a1Mh1R7mn1/+vhQWFptzzPsZo0/w08BL0aT6aQ15lUgSdJpfHe
	Kol2z/F90F2O29TTJ0tZU8C4G/SheSY6N6nRQK8Dpw8lX4dWvFRSD1BiihsPAtCgvk8ZCa9qMiJff
	mCtyXqaAWaMbW4HZvSW7DODrgAqhjkBh58CtMMo2/J48TcA1fRrFu+Ha20qgX4DJCERhBRD21bEJZ
	Jq1/9qcQ==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tmhTh-000955-Bq; Tue, 25 Feb 2025 00:03:15 +0100
Message-ID: <d10a2e94-7bab-46d8-99cf-6365f0b930cb@igalia.com>
Date: Tue, 25 Feb 2025 08:03:03 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/sched_ext: Provide consistent access to scx flags
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org
References: <20250224224959.264808-1-arighi@nvidia.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20250224224959.264808-1-arighi@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrea,

On 25. 2. 25. 07:49, Andrea Righi wrote:
> Make all the SCX_OPS_* and SCX_PICK_IDLE_* flags available to the
> user-space part of the schedulers via the compat interface.
> 
> This allows schedulers / selftests to set all the ops flags in
> user-space, rather than having them split between BPF and user-space.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>   tools/sched_ext/include/scx/compat.h | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
> index 03e06bd15c738..35c67c5174ac0 100644
> --- a/tools/sched_ext/include/scx/compat.h
> +++ b/tools/sched_ext/include/scx/compat.h
> @@ -106,14 +106,20 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
>   	return false;
>   }
>   
> -#define SCX_OPS_SWITCH_PARTIAL							\
> -	__COMPAT_ENUM_OR_ZERO("scx_ops_flags", "SCX_OPS_SWITCH_PARTIAL")
> +#define SCX_OPS_FLAG(name) __COMPAT_ENUM_OR_ZERO("scx_ops_flags", #name)
>   
> -#define SCX_OPS_BUILTIN_IDLE_PER_NODE						\
> -	__COMPAT_ENUM_OR_ZERO("scx_ops_flags", "SCX_OPS_BUILTIN_IDLE_PER_NODE")
> +#define SCX_OPS_KEEP_BUILTIN_IDLE SCX_OPS_FLAG(SCX_OPS_KEEP_BUILTIN_IDLE)
> +#define SCX_OPS_ENQ_LAST SCX_OPS_FLAG(SCX_OPS_ENQ_LAST)
> +#define SCX_OPS_ENQ_EXITING  SCX_OPS_FLAG(SCX_OPS_ENQ_EXITING)
> +#define SCX_OPS_SWITCH_PARTIAL SCX_OPS_FLAG(SCX_OPS_SWITCH_PARTIAL)
> +#define SCX_OPS_ENQ_MIGRATION_DISABLED SCX_OPS_FLAG(SCX_OPS_ENQ_MIGRATION_DISABLED)
> +#define SCX_OPS_ALLOW_QUEUED_WAKEUP SCX_OPS_FLAG(SCX_OPS_ALLOW_QUEUED_WAKEUP)
> +#define SCX_OPS_BUILTIN_IDLE_PER_NODE SCX_OPS_FLAG(SCX_OPS_BUILTIN_IDLE_PER_NODE)
>   
> -#define SCX_PICK_IDLE_IN_NODE \
> -	__COMPAT_ENUM_OR_ZERO("scx_pick_idle_cpu_flags", "SCX_PICK_IDLE_IN_NODE")
> +#define SCX_PICK_IDLE_FLAG(name) __COMPAT_ENUM_OR_ZERO("scx_pick_idle_cpu_flags", #name)
> +
> +#define SCX_PICK_IDLE_CORE SCX_PICK_IDLE_FLAG(SCX_PICK_IDLE_CORE)
> +#define SCX_PICK_IDLE_IN_NODE SCX_PICK_IDLE_FLAG(SCX_PICK_IDLE_IN_NODE)
>   
>   static inline long scx_hotplug_seq(void)
>   {

Looks good to me. Thanks!

Acked-by: Changwoo Min <changwoo@igalia.com>


