Return-Path: <linux-kernel+bounces-349627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8856098F941
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F26A2823C3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151EE1C2323;
	Thu,  3 Oct 2024 21:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpUfdqsU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A526F06A;
	Thu,  3 Oct 2024 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727992443; cv=none; b=A5fJ4/RKrNRhVPhnY/RfPETDxEMybyF8UVsITZGrKD5kkRo6RPLgF44M7KIXM7moOhOFclwob7HWpu9sbRKmYJ77Si8apDht4/gKHMLp0Rn3JcsB9X6dkrufCJMuTpZ/USo5G+Bjp54M2r5m7tDhvZBJxdQ270gqGF+wgpOJ4BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727992443; c=relaxed/simple;
	bh=ykq4pspMFz3hLW6ybfM/6qwDf4lp289eI6rgXUV8oA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ODS3RUCepg/bLoU1Yy2ZKOfxLpoVyI1NeNLlrqpa1tk/yQ3Fnyi+iO78uDTtw1p9RY/OBTbpdixyx6QUCHQgGdwGdNq32IIOJXipSmYblnmKEHfZ5USuPcCl8lplbb3R206DvFqrPOVZZneb3KXz/WJsC8sxZX4czD2MOlIGpnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpUfdqsU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489BAC4CEC5;
	Thu,  3 Oct 2024 21:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727992443;
	bh=ykq4pspMFz3hLW6ybfM/6qwDf4lp289eI6rgXUV8oA8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RpUfdqsU4rFOLanFE8uBBCJGrmV6YtsN4moowfxLvox9GbA6fLzNcr2gtaq8P4LdJ
	 PvNj4nPN4I9djxk8lQXOYUciAteE5gtIv1ZprEIrN/JVOmvKnLvK5tldcQT/WKbeQt
	 eJnF/gHdP1lClPH51jGaSYOyQCXM9NjrT+dQxsBWqUpdxpl2mBi6W+5IS66WNY6KMZ
	 xIarg6MYcqfOSNk8gSELvWgJbSi2fORZcksaLuNfcNRK3HfyCw0MnJSd6Juc3TXcZg
	 nhMIlZOXciXyeTgnlYjB+kJPBz/TebADqWHSz7BkrQh8iDJ4PmnYQ+cc1QBFHIjVFc
	 xLNXHj1NHuGnA==
Message-ID: <fd889e4a-3da7-4ade-a0a4-c4fb1feb540f@kernel.org>
Date: Thu, 3 Oct 2024 23:53:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 25/26] kbuild: rust: remove the `alloc` crate and
 `GlobalAlloc`
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, ojeda@kernel.org, alex.gaynor@gmail.com,
 wedsonaf@gmail.com, boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 akpm@linux-foundation.org, daniel.almeida@collabora.com,
 faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
 lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com,
 jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com,
 lyude@redhat.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-mm@kvack.org
References: <20240911225449.152928-1-dakr@kernel.org>
 <20240911225449.152928-26-dakr@kernel.org>
 <20240928204357.3a28dada.gary@garyguo.net>
 <CANiq72nuZ41eDXkybGBbGRMgJzUOe1rRZioS-amJfH7UV-9cMQ@mail.gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <CANiq72nuZ41eDXkybGBbGRMgJzUOe1rRZioS-amJfH7UV-9cMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/3/24 11:41 PM, Miguel Ojeda wrote:
> On Mon, Sep 30, 2024 at 9:11 PM Gary Guo <gary@garyguo.net> wrote:
>>
>> Would it make sense to throw in a soon-to-be-stable (or
>> already-stable-but-beyond-min-rust-version) feature here to not have to
>> remove the build system support for unstable feature directly?
> 
> Yeah, agreed -- we are going to have `lint_reasons` and
> `arbitrary_self_types` before this series, so it should be fine.

So, I guess you'll just fix it up when applying the series?

> 
> Cheers,
> Miguel
> 


