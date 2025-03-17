Return-Path: <linux-kernel+bounces-563592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CE3A644E8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F32213B0215
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A6D21B8EC;
	Mon, 17 Mar 2025 08:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UtK2JJ9T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBF3847B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742199376; cv=none; b=bS0Zsw+NmnvKRw3+VGmg90JfZwJqBX9MP6/gqNQ3QPoV+nqI6M7Z3Tf3sCBgKbMwAXv+Xq35Aj0uRg3HvmhgMIgcVnSgz39RoXBQpN4+GtJHKm8O5SxNkhDzZaeRpBMkTjwxf4E6bUeJHcZZhU5HlBqowgPSsIQl48NKz6VE8ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742199376; c=relaxed/simple;
	bh=0aexZ8p/UfBpfkmvdM5J6umkMXuw2qZoDMMfIOS7uNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eykM2YrdlUDzwTMfSB4rh7u3rNYrkewJ1Y+Jxv4nlWKBc45uZfdNFzPyXB3UocOn/LbepbRIEM1Kc14zufFE4/grK3VIOqEdl/HT8+ngR49X63RaMwAy8FLLnJjjueKbLVMh81gskgltOAs6E1Ef1IwJyro+w2QK5ateO4SPS+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UtK2JJ9T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742199373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pk3Z6MT/rM/rR8SSxVws+PD86WIVAU1t8UCCgCigTfc=;
	b=UtK2JJ9TLM82AKKPNvLd7GkqlE1YWknFbSdaeBKvP4dNW+K0+H7pdYdJqthK0HtvNZg5Y+
	kXmqfKc1pUiEsIpmYh3/o3xEDcubNP8bhTgPJrfD+6B67KnYIxMH/Oll4rNH+XNxlJkIgB
	C+beglnoHu08pItbXRCW2kYaRtLz/Bw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-oj50330TNiKfKt7uOdn8DA-1; Mon, 17 Mar 2025 04:16:11 -0400
X-MC-Unique: oj50330TNiKfKt7uOdn8DA-1
X-Mimecast-MFC-AGG-ID: oj50330TNiKfKt7uOdn8DA_1742199370
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac28f255a36so319129366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 01:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742199370; x=1742804170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pk3Z6MT/rM/rR8SSxVws+PD86WIVAU1t8UCCgCigTfc=;
        b=CeAlRz7PE/SKobWrGiMOEbqw0+i8rDGvIGJRWi+EumxKYONnykPB5H9022JghcNben
         rmE6yMt+3Ln4mAR0mORoUs+upGHmHY0VzhiJUey0tZPiZld/sDSVrp2si4m2a83YWyHA
         IRQY0Eg0soyY/NpQLZvNi5ZOKJU9oLlOdupEiJrIZle3iCpiJLOKngnthcLllZjLSIZ3
         D0E3KJFQh5iaaKjYI//usIkqEKj698erGvu3QHdY22/xrEfWnPWTyHHtCMGwX7Sf2kZe
         3PmKJHaXbWEq9W/obRvhW5ImoOz5CEFb6nCgp4uLq+x4wQzjpMhl/6VQijcvUadzq7AI
         JIww==
X-Forwarded-Encrypted: i=1; AJvYcCXoGZHiMhvzWRwhPN+zYel1JFKLPjwrv9WZkBU/Do7OzYst3AQPvHoK4hqbLIxaBa+CMK6b3ZJblBWccJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4t1OqQgaNpLdY5551ATzsrlppxee4jTlNdWhgcXZXb72ehvki
	EckcePSNPbnEKhxO31TohRl4C2J0IY3cmwddJ/nMi6cWAq+/0ugLUluqWQ1nypdsbBmutx/l7IC
	EVX6pcIcfuxiSWKOaYKVx3N6ZKrgTEi/qSbhPDcwjmkRqzYCFloaVCa1u40rx1JBC+wUqxtHbig
	leouoz9UuIOhT9Dtj+hXwGMx8ub8L/ShNZMWCd
X-Gm-Gg: ASbGncveNrocSH9vc8zAR+7w31LVfsCSbF6x9iv+M5IjGy047Hr//oxuYGTji7qu3LF
	uFAUcP62IGLZnSaUJVdrx+t5g3FhrDcG5OzGLAgxAHEaqXKcH6LZplgUTdryhotCn7sGPzGjpFQ
	==
X-Received: by 2002:a17:906:c10d:b0:ac2:cae8:e153 with SMTP id a640c23a62f3a-ac3301dd86bmr1393076866b.4.1742199370301;
        Mon, 17 Mar 2025 01:16:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZ+ANShCU4w+973f+bO4wSWXHgTROJUNB6d4D2jlOtA47ZbMlXsZlAyMzOugVcO6O70RQMZNgc+7nWLej/uM0=
X-Received: by 2002:a17:906:c10d:b0:ac2:cae8:e153 with SMTP id
 a640c23a62f3a-ac3301dd86bmr1393074066b.4.1742199369946; Mon, 17 Mar 2025
 01:16:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312190513.1252045-1-sdf@fomichev.me>
In-Reply-To: <20250312190513.1252045-1-sdf@fomichev.me>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 17 Mar 2025 16:15:32 +0800
X-Gm-Features: AQ5f1JrIt2rqvywyLUfYM86c8DkeHlgoLJ6dpuNwUnqQNMtcO8XVVleRuUoD934
Message-ID: <CAPpAL=z9WgrdYNTbKqus+nknfW00HLLZ1VpdowvTfMDAx-Cdfw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/2] net: bring back dev_addr_sem
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, jdamato@fastly.com, kory.maincent@bootlin.com, 
	kuniyu@amazon.com, atenart@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Mar 13, 2025 at 3:05=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> Kohei reports an issue with dev_addr_sem conversion to netdev instance
> lock in [0]. Based on the discussion, switching to netdev instance
> lock to protect the address might not work for the devices that
> are not using netdev ops lock.
> Bring dev_addr_sem instance lock back but fix the ordering.
>
> 0: https://lore.kernel.org/netdev/20250308203835.60633-2-enjuk@amazon.com
>
> Stanislav Fomichev (2):
>   Revert "net: replace dev_addr_sem with netdev instance lock"
>   net: reorder dev_addr_sem lock
>
>  drivers/net/tap.c         |  2 +-
>  drivers/net/tun.c         |  2 +-
>  include/linux/netdevice.h |  4 +++-
>  net/core/dev.c            | 41 +++++++++++++--------------------------
>  net/core/dev.h            |  3 ++-
>  net/core/dev_api.c        | 19 ++++++++++++++++--
>  net/core/dev_ioctl.c      |  2 +-
>  net/core/net-sysfs.c      |  7 +++++--
>  net/core/rtnetlink.c      | 17 +++++++++++-----
>  9 files changed, 56 insertions(+), 41 deletions(-)
>
> --
> 2.48.1
>
>


