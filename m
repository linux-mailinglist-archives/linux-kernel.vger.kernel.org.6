Return-Path: <linux-kernel+bounces-436037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EE89E804C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 15:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575F01883804
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 14:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D92B14830A;
	Sat,  7 Dec 2024 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="LzgoruFX"
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69493ECF;
	Sat,  7 Dec 2024 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733582473; cv=none; b=RBg7WHaCRuCZrnbW2IjwhS9clNlyN/O6PbY0MS1ixviKGMMKj+Vdu/tTSyz/AyxgaOAxvrycT2/8XMSYNmdO0I4t42CEDiQ0V1Ixv5T/jbQmjmoQKAU1RAo+sS1j/lPaL1e7lik1FxbK8PsJuDatYxrgpNM7v2TD/gkJmsphuQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733582473; c=relaxed/simple;
	bh=VBx/TgwHauBV07LNa9AngagEudxpmCUEs+BBokNMpmE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=JAgZPfLekbRAAWSLiCbqxS/2R2oTGY+KPOJMIot9NFW9O43tcQZKLaWI4IowSJCkweEKYER5mbjlA9xN844tsSS2VBs/isnM0yTbZizLSySP8Sla5w6K5C7b1jSR9qd0ej7x2FvjoVjmS7ajvRuyEP7hphvR3PH42y7UfHLfMoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=LzgoruFX; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1733582157; bh=j/ZbQl9W1wyOuJ0jHZ6jIl/gij9r9S4BpbjWGWYD/aY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LzgoruFXvsndxpEHZ/KeUNsdyLB6Iw7kXlnX+9rqJkDpopQIhIR9xHuQk/ID+RG+9
	 RCffBzzYpRJ0NuWaBhCm20u8wN8OEmYmDVu+9EezB7fKB5yQ679Zjn0o6BPPLieNFL
	 iZ6G5fp5YSvb+/8ZpledxA5FInV59HP7bjK/L35E=
Received: from jckeep-Lenovo-XiaoXinAir-14IIL-2020.bbrouter ([124.240.48.126])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 8F70F2A1; Sat, 07 Dec 2024 22:35:55 +0800
X-QQ-mid: xmsmtpt1733582155ta6yz52i5
Message-ID: <tencent_4237DDAC9DC29A9774F0F24D438C0ED31C05@qq.com>
X-QQ-XMAILINFO: MgvSnRA+QZIWFa0Wq3p1t6TXosCLuFwe3R/mUkJu3pMnoKd3h13tzbxLqERM2P
	 ZHWkZN0fu+2b6H+Ioba1sjiwIkWpgWBYTlCBk3MFK/3zUVy+vkbJP+Jd+y4SQhMkvelV1byz1c6J
	 caLAlYvbdXu1GYjskGo0gynJ0RM11iV96wVCoSa/xBQLnGEDDnYHhMa3Bf21isJ5AzKqnUSZqLlM
	 9rQOGHswIJScvx0fEeVrBqBAhvv7o4rVPMx7G9OSkw3pZbBV1DrK+V+oj67Teg5c/d8AKdHOPhAn
	 Iim4kTvoymm1BfUzz9ZhGwhPbUXuOAaIMopq+MPq3gTHYM2rWK5sK5po7mNq415mllEK1kV1RFeg
	 oWMoZT9whsj7+DjcaWoJ2D4SD8LsalB1K0024U97/FM5mBMYCGP8U0WzniaVc+w5gF4N6wGxpIn9
	 EiOREihvpDNlnFg5v+BMyBFIXWASj0N5eLHH5NtGF1+f5n4YQODz63V7LKG/EoGPKglyVyBAwW90
	 PyVWTL9pqXXKM0Emhr2Pty8hw02hdu/y+mQAhOOTZX4yJNYJlhZOla0WNYWOHGWCwaMKv7Nai7vo
	 aQ10YXKwL3dNzw/SMrJA6LSClOHZXL6eQvex/+UsTJNEXaoVFOH46m45JJDrhvTt6GZ+6yx+QPgq
	 v7Y81cxSSMcTlIiFoJofdpDelI9Ul0ujrxAYo0FKpIB9FotaJ5SZ/tUqWW3e1tPlZyb6/m9B0uB5
	 cIwPVhavYDdRbTnC3mJ932Y9/EW1NZU8AsLlEGQEvsxErh3afR1qYPqZjxQ8LP/bYcUfuQGVkZLW
	 E8zM7p+N1PJnh/b7wnZs2k2H8rBRUYqZbrpL9QYXFNUfNqVBjkkNPP9R2ZpcuA1uHsT2hp2dy5Cr
	 5/VYPlp5lRCV0A0Tuy4QGONMfLa0cxdWjtPpusf4CyxFPafAsor+OfyqbyLZ1sp22BREx0pdrfug
	 8F2Tj/8vy9cvdrfLBB8w==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Guangbo Cui <2407018371@qq.com>
To: a.hindborg@kernel.org
Cc: alex.gaynor@gmail.com,
	aliceryhl@google.com,
	anna-maria@linutronix.de,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	frederic@kernel.org,
	gary@garyguo.net,
	linux-kernel@vger.kernel.org,
	lyude@redhat.com,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	tglx@linutronix.de,
	tmgross@umich.edu
Subject: Re: [PATCH v4 02/14] rust: hrtimer: introduce hrtimer support
Date: Sat,  7 Dec 2024 22:35:54 +0800
X-OQ-MSGID: <20241207143554.899948-1-2407018371@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206-hrtimer-v3-v6-12-rc2-v4-2-6cb8c3673682@kernel.org>
References: <20241206-hrtimer-v3-v6-12-rc2-v4-2-6cb8c3673682@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> +#[macro_export]
> +macro_rules! impl_has_timer {
> +    (
> +        impl$({$($generics:tt)*})?
> +            HasTimer<$timer_type:ty>
> +            for $self:ty
> +        { self.$field:ident }
> +        $($rest:tt)*
> +    ) => {
> +        // SAFETY: This implementation of `raw_get_timer` only compiles if the
> +        // field has the right type.
> +        unsafe impl$(<$($generics)*>)? $crate::time::hrtimer::HasTimer<$timer_type> for $self {
> +            const OFFSET: usize = ::core::mem::offset_of!(Self, $field) as usize;
> +
> +            #[inline]
> +            unsafe fn raw_get_timer(ptr: *const Self) ->
> +                *const $crate::::time::hrtimer::Timer<$timer_type>

Hi Andreas, an extra `::` here.

Best regards,
Guangbo Cui


