Return-Path: <linux-kernel+bounces-364577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A10799D662
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22751F238E2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFFE1C8785;
	Mon, 14 Oct 2024 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="kpBXn5EE"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006AF1FAA;
	Mon, 14 Oct 2024 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728930122; cv=none; b=JvKwy4cF2oE5WCddsIUc6PfOMv9QTlnyaJJ5dTsKwjAocE0LHNq2vdAKTnL424/GwYDL1BiC2XFpmoyi3MFi2crTKVP6Rpsn8rAnK1wp/cfk+D+VaijaSHifUyeMeOZMYu0AVBs+on7akFHOzEHqq78gf2O7pdU5o8A2EYj3oug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728930122; c=relaxed/simple;
	bh=RYWJhD4avTH3LS7540U6bEmGVhpem0ClBLlJUEQ07Wo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q2KoiZqotq+3PNS4BCEI0b9rDTN0Xa9wur29+1XJfimbuBR7r7Kkw4rHDKaPcG0b21MaZy5O0SfHmDb7w4tYyXLoKpzsVZlZfMV+59fHSNHwsSV+/oFo/sxewbmWcZ0V554a0K0gH/lr1gHspEWzv/7G1f1fqK9dBo1BnAB9kiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=kpBXn5EE; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1226042BFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728930120; bh=tJUYbtFkO2o0Z+VD382yux/kSn4dPnJekgpVL+9vBgo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kpBXn5EEu1xLHUG7iiNTeCHIU0LJUzz8lj2VssE3NSdrJ0z0DX+q6Oize/h7WXNbY
	 4TR8vtJqep0NOsSyUFlPeDiF2vt07mniYaaHQgV1DtkdVJrHLOjn6OhCWQ3liGWiL0
	 xG8/USHeDofR8IAKM6F4ySbG/qF818Y9X1HWEjoLSEw6oLmqoBl/UP5gL3/kvjoH9G
	 lC050/UDA3JeSjyTQsf6foPYhy9oHrl0cp+wumbj7doifONqjP9iTmTjXDLABs7JwE
	 RNwSZnoZ730LLChfEwKIBNUJOiQN8OI9V6mpZlewhCS9nyxCMQbmWF0wwam1SS3/Rp
	 HDRngyKjuwUsQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1226042BFE;
	Mon, 14 Oct 2024 18:22:00 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/kernel-doc: Do not track section counter across
 processed files
In-Reply-To: <20241008082905.4005524-1-wenst@chromium.org>
References: <20241008082905.4005524-1-wenst@chromium.org>
Date: Mon, 14 Oct 2024 12:21:59 -0600
Message-ID: <87iktusfy0.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chen-Yu Tsai <wenst@chromium.org> writes:

> The section counter tracks how many sections of kernel-doc were added.
> The only real use of the counter value is to check if anything was
> actually supposed to be output and give a warning is nothing is
> available.
>
> The current logic of remembering the initial value and then resetting
> the value then when processing each file means that if a file has the
> same number of sections as the previously processed one, a warning is
> incorrectly given.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Found this while improving and checking the kernel docs for the
> regulator core.
>
>  scripts/kernel-doc | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 2791f8195203..c608820f0bf5 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -2322,7 +2322,6 @@ sub process_inline($$) {
>  
>  sub process_file($) {
>      my $file;
> -    my $initial_section_counter = $section_counter;
>      my ($orig_file) = @_;
>  
>      $file = map_filename($orig_file);
> @@ -2360,8 +2359,7 @@ sub process_file($) {
>      }
>  
>      # Make sure we got something interesting.
> -    if ($initial_section_counter == $section_counter && $
> -        output_mode ne "none") {
> +    if (!$section_counter && $output_mode ne "none") {
>          if ($output_selection == OUTPUT_INCLUDE) {
>              emit_warning("${file}:1", "'$_' not found\n")
>                  for keys %function_table;

So I am curious, have you actually seen a spurious warning from this?  A
normal build does not emit any here.

The current logic is indeed screwy, I'll apply this fix.  But
$section_counter kind of seems like a holdover from the docbook days and
maybe isn't needed at all anymore?

Thanks,

jon

