Return-Path: <linux-kernel+bounces-196493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CA18D5CFC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011D51C244BC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AE3153BEE;
	Fri, 31 May 2024 08:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UfYrAAWd"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F48C153BC1
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144934; cv=none; b=cBVcTz4QP8CB5ZMhTgd5UmufrbUz6xMpsoHmtomgPql8CIK6p3dsqyWPQ6rd8T+Lh171PwBvde9CLED4O69/uU3/uSB6dtO9qXbUvuHuntHxGTLBeSxNMrmQmBdb6rYx7xATgHQpAmZJt1sxEmsFxqhveTlTJzKCtAUWMjJSEow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144934; c=relaxed/simple;
	bh=4yK9SyBdW0zgwmNl9s3wi8n2UWcuNwjF8EG8EoaUDU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X60YUuaDI3ADC/5pCFczcPMVYa2nPndIsxhdFtQtE/aC30ExBYjOxUWfQBQiCpsqDYZkfFFlpFFKfzvOdRIKj4u8Fu+je7aD+IC2BbWJ1gM5SYyxYryAZmY4aorYkFifzkqm7QVXmbfqJv4BqiP+kimvmBszbaIuXbe7NcOaf8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UfYrAAWd; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a20c600a7so1811615a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 01:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717144929; x=1717749729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fnEJF5YFjXx3H2Urn60X/VuHjAoAlnqwvGpoDCqgBZM=;
        b=UfYrAAWdHylShCEbxzOoeOw0Y8FuzftgA7pjjJVrdlGGvFxn9WYr3PQfb0URxtY+Zv
         c54xnW/qxO+Cd9eaBn95RZb4oQe0P/tEznbVq9qRwYtEO5oktDtr4zEr50SeQP05PUTK
         2bPkqA36Ip+O4cFSsDliBm3Va39q9pxcb15pDvGRXNdJWsBMRCZ8wn7BycR7x7FHa2YX
         Wjs2vLsrqQMTQjLbu/MSRKqBCQZ15TNVYiY3KNd422BTzPjPsuu4BNyFgA+8jAcjTRuG
         BTaAi7F9lBZn6EM7YdY7ozLgm6dfIXOWwINt1AVOLTsGXFn7qssTjEQfU0jKFvXGY4Vv
         9cqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717144929; x=1717749729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnEJF5YFjXx3H2Urn60X/VuHjAoAlnqwvGpoDCqgBZM=;
        b=BDcARi/xjXKY1j0hOmaZTci8zcgRzZ5bDMscElQ+WiRP4mcLw8vjEFdUiYCjBPcrNr
         kpOlaeWX79puQ1reh4DHjKkgrMK75jIb4sMMHscacZ1Rl3HZk8cvKgWWRsksqj2EUyBD
         lQOyKP767Lu8TDwiBEfn0tCJCGVRN0xIdETkJyp6ZqNU6b5Qmmp6ZdwLcW3kTSUMRZP2
         4rBfJpMUYMMpBAFZJTnssfTFDCJG1mMp/ZRuJ8BsMc9yIenm7ilm6PErBjfJubQ8ovNM
         1NlZG+Ga9P+2ic+AzkJGq8SIN5SGlewW3sQHnfuPqTsYLZ/XhzgqKB9FsRDWKPiCX5mP
         MuZg==
X-Forwarded-Encrypted: i=1; AJvYcCWgesIMmIiN3XXdTMlwBrDemJAy66jCEmIjQgUB6ET9b2Ju9ucCMl3G5pHYgcLCGRMvvMm0MpOzzge/L0KfFc4lj0GxQkKLnmcebCZl
X-Gm-Message-State: AOJu0YzRYqrFucSfC4xb0OU1XwR0inUUFcs6QUbNUrZvfrFTz9wamOU+
	cVxKMFYvXGCA9v6AuZvcQRbasQPHY82mczR5j4x+Me0OfjIJk4Wt/KcsWwwU0a0=
X-Google-Smtp-Source: AGHT+IFaI4U2rH2Rd9l/+r9yzVCwe48OPbQ3/TkHlZBslQk9PqBEy0Gw2qtSg9KR6sBLoLVxmyYr1A==
X-Received: by 2002:a50:d4d9:0:b0:573:5c18:c2d5 with SMTP id 4fb4d7f45d1cf-57a36382781mr872799a12.3.1717144929374;
        Fri, 31 May 2024 01:42:09 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31bb8282sm734725a12.25.2024.05.31.01.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 01:42:09 -0700 (PDT)
Date: Fri, 31 May 2024 10:42:07 +0200
From: Petr Mladek <pmladek@suse.com>
To: Ryan Sullivan <rysulliv@redhat.com>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, mpdesouza@suse.com,
	jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, shuah@kernel.org
Subject: Re: [PATCH] tools/testing/selftests/livepatch: define max
 test-syscall processes
Message-ID: <ZlmNX78SCFX2Kj3O@pathway.suse.cz>
References: <20240529201941.13968-1-rysulliv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529201941.13968-1-rysulliv@redhat.com>

On Wed 2024-05-29 16:19:41, Ryan Sullivan wrote:
> Define a maximum allowable number of pids that can be livepatched in
> test-syscall.sh as with extremely large machines the output from a
> large number of processes overflows the dev/kmsg "expect" buffer in
> the "check_result" function and causes a false error.
> 
> Reported-by: CKI Project <cki-project@redhat.com>
> Signed-off-by: Ryan Sullivan <rysulliv@redhat.com>

Looks reasonable.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

PS: I am going to queue it for 6.11. I will add it into
    a pull request for 6.10-rcX if there will be another more
    critical fix which would need such a pull request.

