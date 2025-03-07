Return-Path: <linux-kernel+bounces-551156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 507F1A568C8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A673AFEE6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE052219A93;
	Fri,  7 Mar 2025 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OVtHNwYT"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0E339ACC;
	Fri,  7 Mar 2025 13:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353803; cv=none; b=XG/g7aMiJANcPBSSDcG9Y9YNGYH2FdTbBFOYJaZZcEIPXZJLVLNE4dBUUumM8Jl6BaqmEokp1eECYZoX2cJscRRmCZ8d+r+2/HRXtDLVuGTaCavScTw3l319i5RILfSWDHQfuoBwcLCiXIzx6Sp33PUGXJ718yyRiDrNSTE2oUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353803; c=relaxed/simple;
	bh=4WxMkD6CWyChQWUEG9Os74cWrdBRR9i/mnauP29FhQA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFMcIbufijHHrtnvVsqUvWCXbdWc1Q1GaSY3V2020O6kDusLDSGTsCrvRHLZSDCB/lzzgmOn2DH4He5AnRrOyfPICitA8QevysvznIeB6ZBOmGETyLD13Jq1KTDezS0puaJHR65ak70b/jzVp1SBfGVaTzCRC2xqCUfiKhEBxjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OVtHNwYT; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741353800; x=1741613000;
	bh=4WxMkD6CWyChQWUEG9Os74cWrdBRR9i/mnauP29FhQA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=OVtHNwYTOnfPsM5SvBMF8K8nqWh2pTMDquHO8MEK+SNTE2q4odDI5WQ/Q6G7shTp1
	 GZGJy4/xHWlZto/RLuWVxkRzQgMePqqwOy6sSgNmslLN24gIkkn/tb6eeTVgPt8hcX
	 AaAMRVVqp/7nSpL+pv2g0RAE808bO3JyQvk8yX+/Oj7+/j9Sx8qDa6E+VsXq0nbRxQ
	 kAs2JSAMCgkSmbmz7ll/LmcnzMtG1GjsTbc/x/nPPAl1L16YSzNSCLcfq52zwXubfl
	 kCKHb8xiRJU6Jo0ljgsKhK+UI6O91fWgF1a8xE1d3HK7vK7bWi25xA6i7Hyz+B7z3+
	 HOzxvD2TWce/w==
Date: Fri, 07 Mar 2025 13:23:15 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 12/13] rust: hrtimer: add clocksource selection through `ClockId`
Message-ID: <D8A2EFIWWJI6.YSGD4KNNDYFX@proton.me>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v10-12-0cf7e9491da4@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org> <20250307-hrtimer-v3-v6-12-rc2-v10-12-0cf7e9491da4@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 2b7d2f67b764e6bff4b81e640caa986fcc2b35ef
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 7, 2025 at 11:11 AM CET, Andreas Hindborg wrote:
> Allow selecting a clock source for timers by passing a `ClockId`
> variant to `HrTimer::new`.
>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno


