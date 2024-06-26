Return-Path: <linux-kernel+bounces-231149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3901918705
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DC84B2AE82
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957D8190499;
	Wed, 26 Jun 2024 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkqfJP0f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A041190493
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719417863; cv=none; b=k6YgbL7ZRGLiQ8FHjulmZcaiu5Bzt3zwE6GDSK4/SUWDytgBoZ5zyeGu54GET26F+oEMtspBBoCpB6VhvTE2c+oxhmp+Z9aU/kLUoEvTntoTDtNf0LfM0M0xkha/sm7qyVera+hMkOE4vG50sDPfIA0eTg02D3FlFEmXqY9a5wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719417863; c=relaxed/simple;
	bh=yNTzG0J7wNN4igxR6F/IrxrlToSh8eTK5c9Wq8lBZA4=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iwO0NHBH7C9O3YcA/f4g/JC4/mCrFC4gJWyhih4GrZRtHDpnC0j+jxPHvaOReqE7Q5SyUEJ8jBzzFgl5Bgu0hWEP5AVouSzCA2Vg/3pk1EuUVWviZz9aAvNumbk/f7jxiCA9QGAMc5yly5xGaD5C3Os+LLg/ZK2k9+HMkTD+Ejo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PkqfJP0f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719417861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DHjTMyH5Rwk5yjh+iWMH6LJrfct1/DpGEQ3xLofZHeo=;
	b=PkqfJP0fxyB6rNJ/bz5GAykM0oFP9YoNywJpDOjeVKttzwg8gVPl4TDV+3iBc7Yq4LK8+4
	l1RXsC0ntxfnEdh947uJ14v8M6PVdeVQnuJw1pXmlxsV58ybE7AuXW8/grHIO19585MJMH
	ME1+oqvYWXMpebBp7yIVs1sPn4kNYAg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-BwFBdAbBPTequAeccflQsw-1; Wed, 26 Jun 2024 12:04:18 -0400
X-MC-Unique: BwFBdAbBPTequAeccflQsw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6af35481ea6so107338496d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719417858; x=1720022658;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DHjTMyH5Rwk5yjh+iWMH6LJrfct1/DpGEQ3xLofZHeo=;
        b=oJt+Cq3Mz+jrsAFy+kv/B7M0MjMyQdYs5eX4bXPeeESu53qlc3Q0rRPV1yjVxfU4LM
         UtNpczegn/jyyHGJF1Z+QCvy8YmvLEa/IcG7aVrV0qmLwMP+rWe3iT+4ZY+0Ewl5xPyy
         8h3Ty/r4KoSt4rCUjoVdjfInSzu9YwQZrIgGPCRctRGpCGqY8xZ+hqyyKesauoDthd7s
         ko66mjPfL0CFue0B86iam9sIquFU1XXXAcCLTCRrYypzkI8NaSTfo5fCdyRB/d52Fog2
         nnwezPNCiGvR87NQBW17bE/ZIHGkkdl44LS78o6wdEq+sHshEsWejC2WMbXNyBH6/NN2
         6ZNA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ+3erEjwSlFWS/htkhdxL7huZod0Mflt6Kzi0l+Q03B5+suX+CEbw/F/YsX3dgoJ3oKjLSJ6Bsa4zZ2PC23/U49BMrU2GTJvLqHVq
X-Gm-Message-State: AOJu0YzvNqG36VDBn3gzIXgESvoa/Miafm69zB3Sn5+9muzhO2GbdAk6
	TgBJmBdcFJLoP2L0askNeUQ92DH2iqqPhy/mUoteZ02er2IKyHgZzJpW6NJIChjoL/zco/Lv2aA
	dS7Z6Vyzya8ddxXm9TJysCYuZ7sY3Phs/QYcjZv6g8CWxmKrla1zS++/qc905xg==
X-Received: by 2002:ad4:5bef:0:b0:6b5:474a:8f74 with SMTP id 6a1803df08f44-6b5474a96b1mr116364126d6.29.1719417857772;
        Wed, 26 Jun 2024 09:04:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7mtK9WggPDqb2LDlMb/2bFXu9tv4zKoByK+QchHf6bUv6I5JnQc+16tYBiRf6dJ+/0v+J9w==
X-Received: by 2002:ad4:5bef:0:b0:6b5:474a:8f74 with SMTP id 6a1803df08f44-6b5474a96b1mr116363476d6.29.1719417856953;
        Wed, 26 Jun 2024 09:04:16 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:523b:c871:32d4:ccd0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ed18e44sm56047916d6.40.2024.06.26.09.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 09:04:16 -0700 (PDT)
Date: Thu, 27 Jun 2024 01:04:11 +0900 (JST)
Message-Id: <20240627.010411.908967860275845205.syoshida@redhat.com>
To: kuniyu@amazon.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller@googlegroups.com
Subject: Re: [PATCH net] af_unix: Fix uninit-value in __unix_walk_scc()
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <20240625195849.55006-1-kuniyu@amazon.com>
References: <20240625152713.1147650-1-syoshida@redhat.com>
	<20240625195849.55006-1-kuniyu@amazon.com>
X-Mailer: Mew version 6.9 on Emacs 29.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 12:58:48 -0700, Kuniyuki Iwashima wrote:
> From: Shigeru Yoshida <syoshida@redhat.com>
> Date: Wed, 26 Jun 2024 00:27:13 +0900
>> KMSAN reported uninit-value access in __unix_walk_scc() [1].
>> 
>> In the list_for_each_entry_reverse() loop, when the vertex's index equals
>> it's scc_index, the loop uses the variable vertex as a temporary variable
>> that points to a vertex in scc. And when the loop is finished, the variable
>> vertex points to the list head, in this case scc, which is a local variable
>> on the stack.
> 
> Thanks for the fix !
> 
> More precisely, it's not even scc and might underflow the call
> stack of __unix_walk_scc():
> 
>   container_of(&scc, struct unix_vertex, scc_entry)
> 
> 
>> 
>> However, the variable vertex is used under the label prev_vertex. So if the
>> edge_stack is not empty and the function jumps to the prev_vertex label,
>> the function will access invalid data on the stack. This causes the
>> uninit-value access issue.
>> 
>> Fix this by introducing a new temporary variable for the loop.
>> 
>> [1]
>> BUG: KMSAN: uninit-value in __unix_walk_scc net/unix/garbage.c:478 [inline]
>> BUG: KMSAN: uninit-value in unix_walk_scc net/unix/garbage.c:526 [inline]
>> BUG: KMSAN: uninit-value in __unix_gc+0x2589/0x3c20 net/unix/garbage.c:584
>>  __unix_walk_scc net/unix/garbage.c:478 [inline]
> 
> Could you validate the test case below without/with your patch
> and post it within v2 with your SOB tag ?
> 
> I ran the test below and confrimed the bug with a manual WARN_ON()
> but didn't see KMSAN splat, so what version of clang do you use ?

Thank you for your comment!

I ran the test below without my patch several times, but it couldn't
catch KMSAN splat.

Perhaps this issue depends on the state of the stack. Even the repro
created by syzkaller takes a few minutes to catch the issue on my
environment.

I used the following version of clang:

$ clang --version
clang version 18.1.6 (Fedora 18.1.6-3.fc40)
Target: x86_64-redhat-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
Configuration file: /etc/clang/x86_64-redhat-linux-gnu-clang.cfg

Thanks,
Shigeru

> 
> ---8<---
> From: Kuniyuki Iwashima <kuniyu@amazon.com>
> Date: Tue, 25 Jun 2024 19:46:59 +0000
> Subject: [PATCH] selftest: af_unix: Add test case for backtrack after
>  finalising SCC.
> 
> syzkaller reported a KMSAN splat in __unix_walk_scc() while backtracking
> edge_stack after finalising SCC.
> 
> Let's add a test case exercising the path.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> diff --git a/tools/testing/selftests/net/af_unix/scm_rights.c b/tools/testing/selftests/net/af_unix/scm_rights.c
> index 2bfed46e0b19..d66336256580 100644
> --- a/tools/testing/selftests/net/af_unix/scm_rights.c
> +++ b/tools/testing/selftests/net/af_unix/scm_rights.c
> @@ -14,12 +14,12 @@
>  
>  FIXTURE(scm_rights)
>  {
> -	int fd[16];
> +	int fd[32];
>  };
>  
>  FIXTURE_VARIANT(scm_rights)
>  {
> -	char name[16];
> +	char name[32];
>  	int type;
>  	int flags;
>  	bool test_listener;
> @@ -172,6 +172,8 @@ static void __create_sockets(struct __test_metadata *_metadata,
>  			     const FIXTURE_VARIANT(scm_rights) *variant,
>  			     int n)
>  {
> +	ASSERT_LE(n * 2, sizeof(self->fd) / sizeof(self->fd[0]));
> +
>  	if (variant->test_listener)
>  		create_listeners(_metadata, self, n);
>  	else
> @@ -283,4 +285,23 @@ TEST_F(scm_rights, cross_edge)
>  	close_sockets(8);
>  }
>  
> +TEST_F(scm_rights, backtrack_from_scc)
> +{
> +	create_sockets(10);
> +
> +	send_fd(0, 1);
> +	send_fd(0, 4);
> +	send_fd(1, 2);
> +	send_fd(2, 3);
> +	send_fd(3, 1);
> +
> +	send_fd(5, 6);
> +	send_fd(5, 9);
> +	send_fd(6, 7);
> +	send_fd(7, 8);
> +	send_fd(8, 6);
> +
> +	close_sockets(10);
> +}
> +
>  TEST_HARNESS_MAIN
> ---8<---
> 


