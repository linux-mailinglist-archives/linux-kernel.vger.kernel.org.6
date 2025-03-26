Return-Path: <linux-kernel+bounces-577535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2544FA71E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EABF3BBE8C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5A725335A;
	Wed, 26 Mar 2025 18:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TdgO+cMV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471F725333E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 18:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013621; cv=none; b=eNDODIt1XQm6u88yHkD2m/42P69bGo6prqWL2PVXKVTJk+E1N2mh/otJ2k2BUwSkAEUDUzlUXkfaoDoKaG3reKHlrr9++MlZzHZGnoRkv3KjrIlzXJtifSSOaMlFGPlpXA5a+cfXx7tXD/pi3JVBJEWReE11IMipWDAxzENOlCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013621; c=relaxed/simple;
	bh=rjqzotPitDbSi6AMoocqz7K3keGzhX35QvWXCskJ6fI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WSc1TVTJ3xwKMnIaYMUeeQWM5AWuhI7H2W5mnJd0EEXALy0mo+wBPWuaazUveuiTu4Ca6JcH08JUEHMmKXGub3lP1LuwWt4uZ5LyIeEPlPJKWi5ZT5/YqS7npUHiQkorq2uYrG7f7Y4WkxFw91yFWhUc3B+rRAnto7hho+BTs5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TdgO+cMV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743013618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RD1tduM0JJrmq9tfzMhxIULme7KP22Adkm/XMP1vPHo=;
	b=TdgO+cMVRPka4Zl/MpgbbGaVsWZPOQTcbbUwRSedIlrwSB6EdunYWWBy/gd+XaeRWgQoUR
	Z4jpXfVEB+NHKOQr6NXaKNyFGq5dtH1hC9TOJOywJ2DKPpY6U4cQK7DjJ8uR7ksoiD/G6x
	SchmIZFC8wfwBZ+tSSk6al2+18b5lGU=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-qUmfqAOaMLuVZG0-S0VZpQ-1; Wed, 26 Mar 2025 14:26:56 -0400
X-MC-Unique: qUmfqAOaMLuVZG0-S0VZpQ-1
X-Mimecast-MFC-AGG-ID: qUmfqAOaMLuVZG0-S0VZpQ_1743013616
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-85dad58e80fso36029139f.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 11:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743013616; x=1743618416;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RD1tduM0JJrmq9tfzMhxIULme7KP22Adkm/XMP1vPHo=;
        b=XG+aiEYGfExQfwxgOC2ZtB++wQ18kltFPqjvhenZDJgnf3C4F+9g9esOm5KYBLgqHq
         exzBSatdfxLJYAAJjinTVjyADjHK1toUZ8doTp83ZYsQMUhICNKy+pKgiJG+gNjWGpOI
         SEaJzEDuidAalXqGMkbzOlcYUnAeHWnZx+K/nv+OK1f4cAGB65XTysFOr1cp3X3BUDk7
         ut8BgtpnXZYC3H8pq4qQPqFc1KLCC4jKmjNbnozAEtoYo2WGFm80h6LgNCTax9une2Wm
         br4qzktlZTzRdYjedWq3ZJPYceFAhvrS+ioZbCv5B3q+qntYdQOr+QN8kZ93sZjpV1ab
         zT2g==
X-Forwarded-Encrypted: i=1; AJvYcCXPPYwuTotflNLzJDroLhMXsCYgt6w/QhVlNutsizzGvGTncTtG7hBlL4LncgjxoVo5N5cDx8zvPfX9hv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvW7+e+vBkgMt2RPe4gXoR4jS7+kWpsEZ6UKYSO4xibteQu6qi
	eg/9/va0nTkOh5j0YeSC1ZppL5HZx3az/VxapI4s9rUEG9K/PfmmFu7TmEExNlVrxCgSVlSPMC9
	t6pYkg68bBn+A0Sy9KwCc9cw6duu9es0JSARux+Cr8vrep0faHCRhYgNxeXtm1Q==
X-Gm-Gg: ASbGncsrN/nxB1JKBgQTTW21C/XWl7G+GEA2vwHZ+gxr/R4o2beG5Fv13A1sh8Ukjxl
	0d6nuqVPc/qJiZoRQ3G4bL5MbVBTXdpFPTACFkfALk4BLky+66pvdEMYn7dWowkPqoUWOkMN2IF
	qsWT0nB3EXBdFZ0yqWtcFSfOkQu1GM3qrpyWK46MGM+kcLHGyJta4uNIPfEOwFh0ZlCSxU1fiab
	sB3S5K4eKKrxWiZEk8bEpZ7iRzix/jyutxJuU69raZMxinlji0qys3gzSDo7hfLcIys0McNK6bM
	0ab1VQ0nxbwnRWdEsgafREnUAjACcigmxlLSBx8MU0QJvI8R1EqGUkbPjSBSnA==
X-Received: by 2002:a05:6602:3f08:b0:85d:a5d3:618c with SMTP id ca18e2360f4ac-85e821415d9mr99697239f.11.1743013615984;
        Wed, 26 Mar 2025 11:26:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa7giVwJxWHhd8d6z4Js/FPx25T/j6DcERtcIBtPbM3be5/ybdDEVBhZBGciMSfyOBbMrCpQ==
X-Received: by 2002:a05:6602:3f08:b0:85d:a5d3:618c with SMTP id ca18e2360f4ac-85e821415d9mr99694639f.11.1743013615549;
        Wed, 26 Mar 2025 11:26:55 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbdb3b79sm2938719173.1.2025.03.26.11.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 11:26:55 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5f02cf04-74bf-46e5-8104-a62d4aca2bfd@redhat.com>
Date: Wed, 26 Mar 2025 14:26:53 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking: lockdep: Decrease nr_unused_locks if lock unused
 in zap_class()
To: Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
References: <20250326180831.510348-1-boqun.feng@gmail.com>
Content-Language: en-US
In-Reply-To: <20250326180831.510348-1-boqun.feng@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/26/25 2:08 PM, Boqun Feng wrote:
> Currently, when a lock class is allocated, nr_unused_locks will be
> increased by 1, until it gets used: nr_unused_locks will be decreased by
> 1 in mark_lock(). However, one scenario is missed: a lock class may be
> zapped without even being used once. This could result into a situation
> that nr_unused_locks != 0 but no unused lock class is active in the
> system, and when `cat /proc/lockdep_stats`, a WARN_ON() will
> be triggered in a CONFIG_DEBUG_LOCKDEP=y kernel:
>
> [...] DEBUG_LOCKS_WARN_ON(debug_atomic_read(nr_unused_locks) != nr_unused)
> [...] WARNING: CPU: 41 PID: 1121 at kernel/locking/lockdep_proc.c:283 lockdep_stats_show+0xba9/0xbd0
>
> And as a result, lockdep will be disabled after this.
>
> Therefore, nr_unused_locks needs to be accounted correctly at
> zap_class() time.
>
> Cc: stable@vger.kernel.org
> Signee-off-by: Boqun Feng <boqun.feng@gmail.com>

Typo: "Signee-off-by"?

Other than that, LGTM

Reviewed-by: Waiman Long <longman@redhat.com>

> ---
>   kernel/locking/lockdep.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index b15757e63626..686546d52337 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -6264,6 +6264,9 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
>   		hlist_del_rcu(&class->hash_entry);
>   		WRITE_ONCE(class->key, NULL);
>   		WRITE_ONCE(class->name, NULL);
> +		/* class allocated but not used, -1 in nr_unused_locks */
> +		if (class->usage_mask == 0)
> +			debug_atomic_dec(nr_unused_locks);
>   		nr_lock_classes--;
>   		__clear_bit(class - lock_classes, lock_classes_in_use);
>   		if (class - lock_classes == max_lock_class_idx)


