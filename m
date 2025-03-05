Return-Path: <linux-kernel+bounces-546644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78886A4FD3B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865E3169085
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1B523314A;
	Wed,  5 Mar 2025 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iY4/RHxm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED91C230999;
	Wed,  5 Mar 2025 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172929; cv=none; b=rbbTb4/K5uzNQJJu8JWnpPqpu/8TffsqcBuV5HyUuk0Cd0OQQMmzqLwIep0U/A7MW1+A+m+mecsiv3dkXbFRAfjf1111yDKKWvmv/pa04oOE7w8GNCo3tEN3fwa6/fVRY+ahMRyIfQ09rHLQgspF9UkBDOqs0JiwrV0pXlIf99k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172929; c=relaxed/simple;
	bh=yWZTTeKxN8nL5RGzPXzNAnHrZZFeb8GWlvbn/9ISyTc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VqkzYQvVqS8gNIfrROc8GrR8gFVt6nCzU90ksd/RythGbe3LL1NdSaOSJqjK8lmDWzKOo7HK9gb8UTSNlKjjKPKBbUxBSzWuuwhDoFhnmsQCOIIyvToqqnOuLVs5RNSk9gdTvK+K/UWqb8Ct/fap3SDLK4yBYpfDu4+tBK2r0YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iY4/RHxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01600C4CEE2;
	Wed,  5 Mar 2025 11:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741172926;
	bh=yWZTTeKxN8nL5RGzPXzNAnHrZZFeb8GWlvbn/9ISyTc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iY4/RHxmzZxe19596aKIctSoRv3k8/3LcPome91wEYYjyjEsDgTKTUVIhQs7xEE4i
	 pjeJbEaBxjdsfPEnYfdHEwTv23uyxEXf0rrl4pDJtffOe6MLvIXhnQqypFOK2jN6z5
	 N/HPhVC0ASot2NQ6qGg8BybfkuCzegpp+8+i0KkHVQ4vAUOCvB9DMu2Bw3lBCPMY4F
	 rU7Vs8Y9EoxL58YduU6TAL1GT3Nfl162FkRdaK+7UDS5o06Voo3huArskXi689TzlM
	 6chDshozHjOBWltjrNTotBnLnq96ykJzhYDCE2iWjSkuiybsilc6F9WOVWMQPnHJeF
	 e7+n04g09CG+Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Cc: "Guilherme Giacomo Simoes" <trintaeoitogc@gmail.com>,
  <alex.gaynor@gmail.com>,  <aliceryhl@google.com>,  <apw@canonical.com>,
  <arnd@arndb.de>,  <aswinunni01@gmail.com>,  <axboe@kernel.dk>,
  <benno.lossin@proton.me>,  <bhelgaas@google.com>,
  <bjorn3_gh@protonmail.com>,  <boqun.feng@gmail.com>,  <dakr@kernel.org>,
  <dwaipayanray1@gmail.com>,  <ethan.twardy@gmail.com>,
  <fujita.tomonori@gmail.com>,  <gary@garyguo.net>,
  <gregkh@linuxfoundation.org>,  <joe@perches.com>,
  <linux-kernel@vger.kernel.org>,  <lukas.bulwahn@gmail.com>,
  <ojeda@kernel.org>,  <pbonzini@redhat.com>,
  <rust-for-linux@vger.kernel.org>,  <tmgross@umich.edu>,
  <walmeida@microsoft.com>
Subject: Re: [PATCH V6 2/2] checkpatch: check format of Vec<String> in modules
In-Reply-To: <CANiq72md_orajH_TREr=ng8Y=o3Xkgw-V5oxbX8vYXOE2UDNaQ@mail.gmail.com>
 (Miguel
	Ojeda's message of "Wed, 05 Mar 2025 12:04:54 +0100")
References: <87tt89gfe4.fsf@kernel.org>
	<20250304205054.207285-1-trintaeoitogc@gmail.com>
	<CANiq72koDba445gMYtC_VEcFk2+O-Xg2-2y6uMyp7onBy=7rcw@mail.gmail.com>
	<4D_uEoEtgYCzOLuPzhX9Vs7J1uScCFl9I8iUfPXkglvk62R7uBUyCd-_o9rqmINGO1eVIm5gGyfC2_25bhigHQ==@protonmail.internalid>
	<CANiq72kNG7jZf+hZARjyAp-uG=x99CrUKZvJYT_icaF0x0G6iw@mail.gmail.com>
	<87v7sngbgx.fsf@kernel.org>
	<6o6Tt0Lz1YrpxN_GP0E60E9u7KFQOnUnvevc2x_vt_Zb6_96DYHobatt6an_o2JtTjnaTUtTM948nnZ_7QdbSQ==@protonmail.internalid>
	<CANiq72md_orajH_TREr=ng8Y=o3Xkgw-V5oxbX8vYXOE2UDNaQ@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 12:08:30 +0100
Message-ID: <87ldtjenv5.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com> writes:

> On Wed, Mar 5, 2025 at 8:53=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>>
>> Right, it needs a bit more tool support than running checkpatch.pl
>> needs. Perhaps we could move it from checkpatch.pl to the rustfmt make
>> target?
>
> That could perhaps be an option for this case, though not sure if it
> applies to all cases, i.e. `checkpatch.pl` also checks things that
> only make sense to check in a patch and also things that are not
> related to formatting.
>
> Perhaps we want an entirely separate thing in `tools/` eventually, or
> even out of the kernel tree, so that it can be easily run as a bot
> etc. like in the past.
>
> In any case, landing checks here is fine (as long as Joe et al.
> agree), they can be moved or removed later if needed.

Absolutely. Just brainstorming at this point.


Best regards,
Andreas Hindborg




