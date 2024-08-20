Return-Path: <linux-kernel+bounces-294103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2923195892D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77771F231DB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBAC191F8E;
	Tue, 20 Aug 2024 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQmMdfUR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F8C1917F7
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724163829; cv=none; b=DNRwFkY5Z6yLKnjgSuo1o46jwleIuEsNu+CDX4g3XBB+oJzW7WWS5c0mSiS/E02TRfA6bJZgDH6z28SQm9UyBmD/Lu3/7toAJfpxckv+IEdBkXn73WGzm96dAePoU3epu8NPud84XyPamDqk7dR5l72ODg/Oi/qIdKi35Gt5QSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724163829; c=relaxed/simple;
	bh=KcPOTb3FaFiQXgtOLKArDiQuoO0b1VRSXNj4X1DjEa8=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4dLcm9k6iwyXyVN1Y1U+sHtAFu4plDPUIkPd5AZROitp/wwW/bbRgHNawVdWAlMrG6ad3V4iDizcrBVxgqWx51hiVWWdEza808lrtUUtzULH/lnvNRWpSYgKSO1CxwQGelQRdi0i5Khjx1caDTw17IkPgngYSwm1NKXDxowfZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MQmMdfUR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724163826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KcPOTb3FaFiQXgtOLKArDiQuoO0b1VRSXNj4X1DjEa8=;
	b=MQmMdfURqkkwbl5OfiJIhRTyPV2tVzeVptPvpnrsLYdaXqtV5agUWNzsk7h4cfX2efPjhJ
	2HjYQGhb0E+xLbW3sxqbCmx92+EdIt9z1hpKUlitIr8tplVRm1Gq1QJ5oO2qDACetVc9yH
	YD1EBY/27F8ej9BRiTq8ogB5AWjSj8g=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-Ey0mCs5JP1mE77Hnbzq0qA-1; Tue, 20 Aug 2024 10:23:45 -0400
X-MC-Unique: Ey0mCs5JP1mE77Hnbzq0qA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6bd94069ceeso115398766d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 07:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724163824; x=1724768624;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KcPOTb3FaFiQXgtOLKArDiQuoO0b1VRSXNj4X1DjEa8=;
        b=EA+jw/wdNeOBYCJZ7M4WYnDaZZUeJeI0KljSebQfTFdGfdb2Z7TVp5w9yS6StlWuKv
         tTvmGByspVWa/XFzkyrvtMDeiMciUgFlnYQVlwJpGhVKDJgrt5fWaoT6KywrsYuJPjyY
         708nUo82UbMNKY1MuSmqaXWf7AhXgv8aDc4b1ZUkmb9ifyNrfx+tRVzProDzRVvwgOZi
         J4DaRpp0Qp4RHl4O2oyrz8xEHeRXnmCt0vhQ0QfKRpntfsXhr5TjoYduMooYEqVVlsrA
         6j5HjLO5GK8fPy2n9OXph7IFHK2qQqFHeNIcDqKI3lqT2RBPu1V4voxiAxyVlhkjbxPz
         nfNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV+WSm14aIvYkcOHf+Gy/NqGLZnpU7SEPEVftnN6aNsqBEIqotE6iFDYO3CK1QbayvqFPjRYLwDh2l8aflBK3p3sr8m4ua1MCwx3ty
X-Gm-Message-State: AOJu0YwIvkXj3MW3GXsxUylJKJ3ZdhYGNd00kcTf22jT1nB/w+HO3yqd
	Ol0uBAqoRHW2NsrMpXfM9nXZaSEpBPoyOcrjmijOB+Uq+5/FZ/R9iyLssJ5BhHW7CBs0IIaLaDq
	2TN9OrZwiRNuqKVzsMtjemfzF3DJ2ilRMY4FhjA5KqK0c9+e0zysL8IHYVvv13lXXYoGWO2AyUM
	nIaUryoII61f+1QhFTpqikRW80fy8Sk3L+34gK
X-Received: by 2002:ad4:4ea3:0:b0:6ad:84aa:2956 with SMTP id 6a1803df08f44-6bfa8905ca5mr48776146d6.13.1724163824450;
        Tue, 20 Aug 2024 07:23:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5vlk5oxybb7HBiwuY/NZaBvGyh2hA5RNecvG14k8qeykvSFP/GlriebmABaXVd50gjrhUMO1BnukHcO443Iw=
X-Received: by 2002:ad4:4ea3:0:b0:6ad:84aa:2956 with SMTP id
 6a1803df08f44-6bfa8905ca5mr48775806d6.13.1724163824154; Tue, 20 Aug 2024
 07:23:44 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Aug 2024 14:23:43 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240815122245.975440-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240815122245.975440-1-dongml2@chinatelecom.cn>
Date: Tue, 20 Aug 2024 14:23:43 +0000
Message-ID: <CAG=2xmMQZ2JgagfUUUF_Cod+3G5Yj=dfnKxEBz1A7Mpj51WR0g@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ovs: fix ovs_drop_reasons error
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: kuba@kernel.org, pshelar@ovn.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, netdev@vger.kernel.org, dev@openvswitch.org, 
	linux-kernel@vger.kernel.org, Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"

On Thu, Aug 15, 2024 at 08:22:45PM GMT, Menglong Dong wrote:
> I'm sure if I understand it correctly, but it seems that there is
> something wrong with ovs_drop_reasons.
>
> ovs_drop_reasons[0] is "OVS_DROP_LAST_ACTION", but
> OVS_DROP_LAST_ACTION == __OVS_DROP_REASON + 1, which means that
> ovs_drop_reasons[1] should be "OVS_DROP_LAST_ACTION".
>
> Fix this by initializing ovs_drop_reasons with index.
>
> Fixes: 9d802da40b7c ("net: openvswitch: add last-action drop reason")
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

The patch looks good to me. Also, tested and verified that,
without the patch, adding flow to drop packets results in:

drop at: do_execute_actions+0x197/0xb20 [openvsw (0xffffffffc0db6f97)
origin: software
input port ifindex: 8
timestamp: Tue Aug 20 10:19:17 2024 859853461 nsec
protocol: 0x800
length: 98
original length: 98
drop reason: OVS_DROP_ACTION_ERROR

With the patch, the same results in:

drop at: do_execute_actions+0x197/0xb20 [openvsw (0xffffffffc0db6f97)
origin: software
input port ifindex: 8
timestamp: Tue Aug 20 10:16:13 2024 475856608 nsec
protocol: 0x800
length: 98
original length: 98
drop reason: OVS_DROP_LAST_ACTION

Tested-by: Adrian Moreno <amorenoz@redhat.com>
Reviewed-by: Adrian Moreno <amorenoz@redhat.com>


