Return-Path: <linux-kernel+bounces-177978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA648C470A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 20:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601281F2274B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3652239FE5;
	Mon, 13 May 2024 18:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gbEhZ5qF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B792C69D
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715625631; cv=none; b=qcvSJXM+fu4n1U4GQUICHhKLZ0HLMkRPkVP4FR/d69EmR7eI8Wx+TsCa6Qxe4X8O+3qxHWwim8SkzrE4U05veg/Qjb4E/NHWJc+oQZtfP6CD9hYDatNoVFa9vWVuzPt2k5oQMBUbJDvJj8zjnxmn1of7P4EqBL6QjhCc+WX0zus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715625631; c=relaxed/simple;
	bh=wsS4m9jNroLUwgmcM5QQE60bNETQtMEKh5JkIRElsQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pjo7DzoJG9VUk060w7P4GTAvKd0WLA1LXS92Bucmq6pqfAt0NqZW7iretKYHuz9qhgaGf9XoQa8d3W46PPIVf9mrCZlKAslkVjFwFVJcHfupLVEhxCYj94xksdp1rNYLZagsEW2nyklBBPucwW3JYdxd4rwCqutrw8CyZn9T6Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gbEhZ5qF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715625628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MFyeuVqyMFnhtNKuGHnJL7fY7DbMXwMj2UMfkdAHlY0=;
	b=gbEhZ5qFBYXjvvymVQs0h7hv/0xU6WngKi6cWLxKyAs2rYfJKoS12c3IoxgLy9IXH0+h7L
	BtmQtQgw1bjDODNDxYMtO1baszDuqrr86ESWtBn5jQTQ5WAC+Yc44ihBQLpaBMNDw6IT9s
	+Sr1CrjH/WmvXLBM0uCxBMuCiOUzfvg=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-hjxm2TuANhytfxRhrnzsTw-1; Mon, 13 May 2024 14:40:27 -0400
X-MC-Unique: hjxm2TuANhytfxRhrnzsTw-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6f3efd63657so4279672b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 11:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715625626; x=1716230426;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFyeuVqyMFnhtNKuGHnJL7fY7DbMXwMj2UMfkdAHlY0=;
        b=Z28XNKol7bJGQe7es+kWPykwKDZ5vmX/SwUIXPWZ2ug+AEFQaKVDfXk2lV82bIMsqo
         kkmcAg6rbrmVCxzSba2eQ8xLrJlORSJyHRdMDfLvUW6xQqJhOJ80Cd+mmoCpGaBOGPsE
         PTt+QGqh7c2O7JfH9Knui7pFQf2nCAKwCBV5EnT/OcI+qGb0iTP9BoAH8pv3o2PX6zvy
         jos81Ml3t3g8bU9gNvBdsZ/onQ4RToz4BffWhQz35y2g+LMRw2f/+cbGy77mQikJdSFv
         AjJJcjnNmWbxE460hVfS8cDAzUfJD7BO4mZaYAlBgMojC309NnG4hQCeuTlL4aAtg1GC
         fv/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/avzAeGmtjjvlF59hr6g8IhYK6anH9wT8UDx8HSqqDmFU3LltAekHvYQzdpKEaie+i3wf/KiU+h6A+u56NemPO1YakgfP0dLJ8YEY
X-Gm-Message-State: AOJu0YypNYzLDpVEivK15tBmLmdreeR5vP4VP7cHAsYg2W96EwYrMyb7
	mX6f6PoY9s0qyxd/md4I5gS16PKafU+WW1CpqKrdLitj/vpZZ8fuLvsfWvSoyV60RffVvXKCvK9
	cpXhQOrI9x64NVCvaMKi+/dNNj9E+pVTxS6hmFB9a6UROWAG7vaOCYZcxJ+c2tw==
X-Received: by 2002:a05:6a00:1312:b0:6ed:21cb:13f3 with SMTP id d2e1a72fcca58-6f4e02ecde9mr11814145b3a.17.1715625626279;
        Mon, 13 May 2024 11:40:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNpxkzGvp2/GZiIYnR8YzUJnMiG6aGHqRC6qc3D1Zm855T1dZqSO+sUiPeYbQB3ZyF0Ya2yg==
X-Received: by 2002:a05:6a00:1312:b0:6ed:21cb:13f3 with SMTP id d2e1a72fcca58-6f4e02ecde9mr11814114b3a.17.1715625625812;
        Mon, 13 May 2024 11:40:25 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a66c54sm8035257b3a.40.2024.05.13.11.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 11:40:24 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, "Paul E. McKenney"
 <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Neeraj
 Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 26/27] rcu: Update stray documentation references to
 rcu_dynticks_eqs_{enter, exit}()
In-Reply-To: <ZjuSTC0sZvuqx57r@localhost.localdomain>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-27-vschneid@redhat.com>
 <ZjuSTC0sZvuqx57r@localhost.localdomain>
Date: Mon, 13 May 2024 20:40:20 +0200
Message-ID: <xhsmhseylh7xn.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/05/24 16:55, Frederic Weisbecker wrote:
> Le Tue, Apr 30, 2024 at 11:17:30AM +0200, Valentin Schneider a =C3=A9crit=
 :
>> rcu_dynticks_eqs_{enter, exit}() have been replaced by their
>> context-tracking counterparts since commit:
>>
>>   171476775d32 ("context_tracking: Convert state to atomic_t")
>>
>> Update the stray documentation references.
>>
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> ---
>>  .../RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst   | 4 ++--
>>  Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg  | 4 ++--
>>  Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg   | 4 ++--
>>  Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg       | 4 ++--
>>  4 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Or=
dering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Order=
ing.rst
>> index 0533814a1f69a..50fc99aba777f 100644
>> --- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.=
rst
>> +++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.=
rst
>> @@ -147,8 +147,8 @@ RCU read-side critical sections preceding and follow=
ing the current
>>  idle sojourn.
>>  This case is handled by calls to the strongly ordered
>>  ``atomic_add_return()`` read-modify-write atomic operation that
>> -is invoked within ``rcu_dynticks_eqs_enter()`` at idle-entry
>> -time and within ``rcu_dynticks_eqs_exit()`` at idle-exit time.
>> +is invoked within ``ct_kernel_enter_state()`` at idle-entry
>
> Looks like ct_kernel_exit_state().
>
>> +time and within ``ct_kernel_exit_state()`` at idle-exit time.
>
> And ct_kernel_enter_state()
>
>>  The grace-period kthread invokes ``rcu_watching_snap()`` and
>>  ``rcu_watching_changed_since()`` (both of which invoke
>>  an ``atomic_add_return()`` of zero) to detect idle CPUs.
>> diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.sv=
g b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
>> index b57210ecd689e..c7d16b72f0973 100644
>> --- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
>> +++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
>> @@ -607,7 +607,7 @@
>>         font-weight=3D"bold"
>>         font-size=3D"192"
>>         id=3D"text202-7-5-3-27-6"
>> -       style=3D"font-size:192px;font-style:normal;font-weight:bold;text=
-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_dy=
nticks_eqs_enter()</text>
>> +       style=3D"font-size:192px;font-style:normal;font-weight:bold;text=
-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">ct_ker=
nel_enter_state()</text>
>
> ct_kernel_exit_state()
>
>>      <text
>>         xml:space=3D"preserve"
>>         x=3D"3745.7725"
>> @@ -638,7 +638,7 @@
>>         font-weight=3D"bold"
>>         font-size=3D"192"
>>         id=3D"text202-7-5-3-27-6-1"
>> -       style=3D"font-size:192px;font-style:normal;font-weight:bold;text=
-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_dy=
nticks_eqs_exit()</text>
>> +       style=3D"font-size:192px;font-style:normal;font-weight:bold;text=
-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">ct_ker=
nel_exit_state()</text>
>
> ct_kernel_enter_state()
>
> etc...

Yes indeed, I shoved the sed the wrong way around :( Thanks!


