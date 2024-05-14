Return-Path: <linux-kernel+bounces-178344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0518C4C3A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 08:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F97D1F216BA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 06:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF711CD38;
	Tue, 14 May 2024 06:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b71O2ZLC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CA31BC5C
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 06:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715667539; cv=none; b=fV3uFrR4Ha7GC6Jg2Pr2mOJkYUB/sbgtmoxddfxye1mmleHSyBJJ6Cjvc13LCxwPoCNCYkZZX3SjlOaA4PRpHhpNjEoUG57c5xcshcyNXCEXSKY4Pz/co/63fiCYtH1T94PSR1dOSba0jYqQvt3zZaiedAV0j0GOs37jxdn1Wis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715667539; c=relaxed/simple;
	bh=qEjGhlQZJJ90rSaBtG/Fvx7YJHzstZH0d56H+Ox7MCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogVNEIZzz3McaUWV0RU+CjdUMbhJPf6TRfL1nyZIJL2OFDeccwPZ+qLaWQFM5JN/uZyUKBbnEHWzmIrbOBQvlzxelip8JcV1al7zlkilCCKcxtbHFHe7QGr+IsBtBL7qyVbuoTh1Y/8dhDVkrgJ1HT0F/MbOs9beBazdmXfW5IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b71O2ZLC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715667536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P6B0DumV2udlVipcUJf/RNNgM5snKSkCNhRyGCU8nt4=;
	b=b71O2ZLCXtWo+BohKX4D/TbOFKPlCBdVN2zmbPW7xUKtYuAUtTvvQnyT47GL7MLFfrWATB
	XABer9amOoY1oxFvtIsZRJvcsT7UJ3BIafJ+liBflAgGSidaHQk8Nm3inigs+co8ct8A9U
	Xfx3AcByKgRKxjOCUiMJqK42GbRkN+Q=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-n-Occhu5Pm61jgUcE6V0_g-1; Tue, 14 May 2024 02:13:43 -0400
X-MC-Unique: n-Occhu5Pm61jgUcE6V0_g-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6f46bf70fd3so2558570b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 23:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715667223; x=1716272023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6B0DumV2udlVipcUJf/RNNgM5snKSkCNhRyGCU8nt4=;
        b=N0ZxgJ/gRUEefPzRMOAzL2XDaA2M6XxrP7Mu6pfBRE1lkPr/qWg4+WXxl6xUnNYl4u
         iqvjOeRZIyYfLZhr0Xynn2BCHa8iWNRLwL96n2gknLEzCV+usdPamEL4sCLneehzR2D6
         nRluBoOdIUBcV0cMSeXvqXxG26sT9aWdzl7c2ntCCwEat2TH6uz7MJAr+oK1ku2zzlFQ
         /jGV4P2xnEAu5UnrEBifgPo2YGOBpk3NQiS/wdGNnJ2HlGaeJk3n7dkQK4EU85k7EKMf
         GqchbVC2Qx8y7I3t8QPeVWOzCMQy5nhyUgbqRF6BLC+cRvbJ9xyAFySWb0Qeji8c6iZg
         RJGw==
X-Forwarded-Encrypted: i=1; AJvYcCWdsevqvizUhqz6LhsIwqsVyYOefgePPOPAUSCIqSKpk2xFa0nAHiP5k+i8D1fHMB7NWVA5HQNudeMJ8NxWAwr3ixb6eSSEJsJTg8uE
X-Gm-Message-State: AOJu0YzINBHZjWdbPHFJkPq04Ro31JL2mT8qdFhn/4CBnGpvEp6bHvI2
	G7/eOGX8rfjLvoCN2YeV4hX1Pl38dicuriooDNqsBsn77mWc1/ah4JHucWSgLsPKuQ3J7qntr6u
	6wDl7s0gGRvNaHml3ligx/ONWMWZeIW0UKzUfD4UuH4wHhqcw/2EE1LCpqOfD0lAWokAEKKtDp/
	Ibjn20dOrM5bXlDQK6JE2OzXovstsis79bsTFo
X-Received: by 2002:a05:6a21:19c:b0:1a3:df1d:deba with SMTP id adf61e73a8af0-1afde0dc95amr12474889637.31.1715667222724;
        Mon, 13 May 2024 23:13:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/yVQHUfYGCuo3MWod5iRA3A17cM+ibG3X8Vh9ykLbjxo2us8ibYX8tJQ2E5RvUodUrPf4VNlb2IEhNNSuVBA=
X-Received: by 2002:a05:6a21:19c:b0:1a3:df1d:deba with SMTP id
 adf61e73a8af0-1afde0dc95amr12474864637.31.1715667222322; Mon, 13 May 2024
 23:13:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509011900.2694291-1-yukuai1@huaweicloud.com> <20240509011900.2694291-3-yukuai1@huaweicloud.com>
In-Reply-To: <20240509011900.2694291-3-yukuai1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Tue, 14 May 2024 14:13:30 +0800
Message-ID: <CALTww28Qjce6jG+v6=8vubiBWoCt5=21_-VE6hgOMU2HZxnF=g@mail.gmail.com>
Subject: Re: [PATCH md-6.10 2/9] md: add a new enum type sync_action
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org, 
	dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
	yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 6:19=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> In order to make code related to sync_thread cleaner in following
> patches, also add detail comment about each sync action.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.h | 57 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 2a1cb7b889e5..2edad966f90a 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -34,6 +34,61 @@
>   */
>  #define        MD_FAILFAST     (REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPOR=
T)
>
> +/* Status of sync thread. */
> +enum sync_action {
> +       /*
> +        * Represent by MD_RECOVERY_SYNC, start when:
> +        * 1) after assemble, sync data from first rdev to other copies, =
this
> +        * must be done first before other sync actions and will only exe=
cute
> +        * once;
> +        * 2) resize the array(notice that this is not reshape), sync dat=
a for
> +        * the new range;
> +        */
> +       ACTION_RESYNC,
> +       /*
> +        * Represent by MD_RECOVERY_RECOVER, start when:
> +        * 1) for new replacement, sync data based on the replace rdev or
> +        * available copies from other rdev;
> +        * 2) for new member disk while the array is degraded, sync data =
from
> +        * other rdev;
> +        * 3) reassemble after power failure or re-add a hot removed rdev=
, sync
> +        * data from first rdev to other copies based on bitmap;
> +        */
> +       ACTION_RECOVER,
> +       /*
> +        * Represent by MD_RECOVERY_SYNC | MD_RECOVERY_REQUESTED |
> +        * MD_RECOVERY_CHECK, start when user echo "check" to sysfs api

Same question with patch 01 here

Regards
Xiao

> +        * sync_action, used to check if data copies from differenct rdev=
 are
> +        * the same. The number of mismatch sectors will be exported to u=
ser
> +        * by sysfs api mismatch_cnt;
> +        */
> +       ACTION_CHECK,
> +       /*
> +        * Represent by MD_RECOVERY_SYNC | MD_RECOVERY_REQUESTED, start w=
hen
> +        * user echo "repair" to sysfs api sync_action, usually paired wi=
th
> +        * ACTION_CHECK, used to force syncing data once user found that =
there
> +        * are inconsistent data,
> +        */
> +       ACTION_REPAIR,
> +       /*
> +        * Represent by MD_RECOVERY_RESHAPE, start when new member disk i=
s added
> +        * to the conf, notice that this is different from spares or
> +        * replacement;
> +        */
> +       ACTION_RESHAPE,
> +       /*
> +        * Represent by MD_RECOVERY_FROZEN, can be set by sysfs api sync_=
action
> +        * or internal usage like setting the array read-only, will forbi=
d above
> +        * actions.
> +        */
> +       ACTION_FROZEN,
> +       /*
> +        * All above actions don't match.
> +        */
> +       ACTION_IDLE,
> +       NR_SYNC_ACTIONS,
> +};
> +
>  /*
>   * The struct embedded in rdev is used to serialize IO.
>   */
> @@ -571,7 +626,7 @@ enum recovery_flags {
>         /* interrupted because io-error */
>         MD_RECOVERY_ERROR,
>
> -       /* flags determines sync action */
> +       /* flags determines sync action, see details in enum sync_action =
*/
>
>         /* if just this flag is set, action is resync. */
>         MD_RECOVERY_SYNC,
> --
> 2.39.2
>


