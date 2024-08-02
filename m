Return-Path: <linux-kernel+bounces-272421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D01945BB3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 12:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7BF81F21D50
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F5E1C69D;
	Fri,  2 Aug 2024 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qa0JRFg8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254833FE4A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722592847; cv=none; b=o0XUD5dcZiYvjneR8CvPNEjsOyFI1OKrV6Ru1j4VPEqZYAH6XxIA1AmWk70Wz5MO9J/bqXOuVviaXwnu3fidbRu9sTaAsUvJcsHlaLICy68hF1yRNY0XEiZm2OAO5TuBCcfYDBqKpO3hVR9FtYa1D9x0WX8ZDnvdWaMp8yriTng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722592847; c=relaxed/simple;
	bh=rX8GSyUhQPYw9wyBC+lYN2xbZncM+5VUIKhRExTNBHM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=elTRvyFxSIeOT2kC/wdDgWVpgySs5MqQma68aJIQjoktUj2GSyDei0ol0qOvvFfpFKEY60VbuNGoysrT+tON/q7NX5cQBNPFbnO/Fm1DPKrqQ1F02y5+zvi9mymR3A9TDo3MgLCUDCKOksSUwUiWXwcgFJh5nPnZ9dKkO0z/x50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qa0JRFg8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C32C4AF0A;
	Fri,  2 Aug 2024 10:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722592846;
	bh=rX8GSyUhQPYw9wyBC+lYN2xbZncM+5VUIKhRExTNBHM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qa0JRFg8Ks1431VpmUZYTEHJ0FA5F5c0ewONVcFPvUxM3a6mpbEE2seKAAxlZIGaN
	 XtysiMc2/EC+ZD1RsQWPr49kGKYUbnuB+d7bKVbt+4rXtJdIWPKg7XOTqipsfAozYF
	 puSLfuzdRyAfAwjInL/WfwxysZgWacWdDynURlo1YvubNNLQZJFgVItd1DQhPw9wHR
	 QwOf89xkj+E1Oww8X/8P61dauySzAKxFv/FqnUT4M3S3HLqfNEKwZzf/ut9L3LH1P4
	 29TWCHIaDP70fuAY7/VyheZOjIAtcoPqn+oJ0goPlmm2ODIQ983ZhgTb66ne+llhfw
	 DTLPi3Lvq5xxg==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6E90C1473F34; Fri, 02 Aug 2024 12:00:43 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ath9k: use devm for gpio_request_one
In-Reply-To: <CAKxU2N_b51S=gDthQtM+aRnCt1Zg1SrodjmLF3u9aV+Y6GefAg@mail.gmail.com>
References: <20240731210052.6974-1-rosenp@gmail.com>
 <87le1godh1.fsf@toke.dk>
 <CAKxU2N_b51S=gDthQtM+aRnCt1Zg1SrodjmLF3u9aV+Y6GefAg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 02 Aug 2024 12:00:43 +0200
Message-ID: <87y15f6y7o.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Rosen Penev <rosenp@gmail.com> writes:

> On Thu, Aug 1, 2024 at 1:26=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@kernel.org> wrote:
>>
>> Rosen Penev <rosenp@gmail.com> writes:
>>
>> > No need to manually free the gpio now.
>> >
>> > Remove if statement as it's redundant now. The gpio bit now gets clear=
ed
>> > whether set or not.
>> >
>> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>
>> So presumably these will conflict with this patch?
>>
>> https://patchwork.kernel.org/project/linux-wireless/patch/3b46f6c7-4372-=
4cc9-9a7c-2c1c06d29324@gmail.com/
> This does not look related.

Ah, no, you're right; was confusing the PCI-internal device managed
thing with the generic one :)

-Toke

