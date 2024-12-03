Return-Path: <linux-kernel+bounces-430241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30519E2E8B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 569D6B2B5BB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AC8207A0F;
	Tue,  3 Dec 2024 21:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SD64SAqH"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3210E1E47C6
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 21:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262605; cv=none; b=oVsTElngylmj85vfgRzJ+R4RZxUWrumcNy7BXrUwl54uja/0Wx4hk80oF+1xIiJkLiwxjAeymC8+PCSJ/PnZKGeWSPc5UMPnx0GWSmu+V7s0IlZhlmjU0t+WKBnkT0DxPwWBOoYxbA5aPc0nMoFTxHajDqlow5HqkY03ms99seM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262605; c=relaxed/simple;
	bh=S52DfKwMNGc5EiRkh/HfsI5lbDqe35eUnjhynS4EPyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qaq0Z7eWk/re8zw0Mi0j0EegaWmY1T+BYaibWkqAKc1HCkWUU7fEhlT9+zQ8pa0PynQ6yUf631abkNSlHRYk5+1MQHsgZ8jj3Xy9WxcXRTTSfbj/Rszz5wbXjaatjY29OZFgM/kTUQo4pETwl/aqt8XJdttaeG1XcZwKBGKTehM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SD64SAqH; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-84198253281so212594539f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 13:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733262603; x=1733867403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hl74QNFi9+204dN29m57Rrn4d5enBoTw7nPdzuHs9Rc=;
        b=SD64SAqH2EJs7zCx6T0WmaYsT5T2MyVRVCqGflvyos9aSjXqEjh6lJp/393L6n8S8J
         ciBWzZRUyP9NgSCo6HEe+sx9kr4kKZyZOpb3uaKYLgo9DMQrAHw/Dy0HS27BDbiplqt0
         rFoUlyz1tKn+v7RwS5410Pj5mgjAcmVE99fsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262603; x=1733867403;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hl74QNFi9+204dN29m57Rrn4d5enBoTw7nPdzuHs9Rc=;
        b=n6AZZPK2Ojn/cH+jrTg2i7ahOOSterpxr001XJFBOLYoPANVrecie4oltsVqBzbS0Q
         wYFiMKSxazufGgZrf3pcOxXSeyC3e/IQ2IqL69eONwVu8/knhNnttOwV6bwTmIHvTYSs
         mLxqwIpc5tXu/cSkwLWKl0Fi93x314ewr4+mMXzAFZ1WBe6oVMIPy2frF80azKyYltgo
         fEtb4Qw9BvhvolnTQUTP2c+6TSJ6kBM2N8mz3GCLmwGm6pq8EZ7DblAgmN0LeKXFeClk
         Mrbt3FqIrpOFUqSpO0haw0AsUkOT6sDUFQmrcfq4PhiYpaQFWdw58OAhOB1FpD1DQHNW
         CWDw==
X-Forwarded-Encrypted: i=1; AJvYcCVNgzJU8NMIDLoWC7IxsMw8HRGxyzIp7fquobyc0hZjICUUX0ZkINyTGFd2B19hrcV3nTZ9c4FpCXx9gZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT0+PfUS7h5m3bLhqltzamvAxwzuj/Lr4ZPuZkXquSKMGcRNg8
	wSsADo1SRKrapWLUiR13dsnGrT/iRI0MKpkFJTbbXG7PCk3oVkPwjJD5uk/zGro=
X-Gm-Gg: ASbGncs9V5go52ybaE3oVTseYvBGUGHG5iNaUfGOTJhY0Cp08dVh7d48wt7f0LEmGCz
	95B0vAjfULQes0ndIAaKnk8X+g6TGUJH4czz0Se13UVzFJFK3Q7BMxBIPOpp6v6p4BoFbTY33bk
	+a3ErNwcxy6tN+E/EntU6hGu/xteCvucRMMEI7mdYupbjhesY4XVdHhz75TXNOoVeOaM3t2HE1z
	FIOrp/DrjwJsOyl+oLJ0IXEVF1WImtUg0JoB42kVPqN931xtOh/eNEjXk8Wgg==
X-Google-Smtp-Source: AGHT+IG7nNwe7zA9gJvUkLM02efBSPZHgWiV5Pu/3sPNlc7wpYvQ76+GXzXV+MXJxcQdj+NfN1jKOQ==
X-Received: by 2002:a05:6602:2cd4:b0:843:e8d0:a728 with SMTP id ca18e2360f4ac-8445b54e8b3mr575381539f.4.1733262603303;
        Tue, 03 Dec 2024 13:50:03 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-84405ec8d88sm269933739f.19.2024.12.03.13.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 13:50:02 -0800 (PST)
Message-ID: <c74c8f0c-f8f0-4005-821d-c0897e5c3f4b@linuxfoundation.org>
Date: Tue, 3 Dec 2024 14:50:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] selftests: tmpfs: Add Test-fail if not run as root
To: Shivam Chaudhary <cvam0000@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241112143056.565122-1-cvam0000@gmail.com>
 <20241112143056.565122-2-cvam0000@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241112143056.565122-2-cvam0000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/24 07:30, Shivam Chaudhary wrote:
> Add 'ksft_exit_fail_msg()', if  not run as root, with an appropriate
> Warning.

This should be a skip - not a fail.

> 
> Add 'ksft_print_header()' and 'ksft_set_plan()' to structure test
> outputs more effectively.
> 
> Test logs:
> 
> Before Change:
> - Without root
>   error: unshare, errno 1
> 
> - With root
>   No, output
> 
> After Change:
> - Without root
> TAP version 13
> 1..1
> Bail out! Error : Need to run as root# Planned tests != run tests (1 != 0)
> 
> - With root
> TAP version 13
> 1..1
> 
> Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
> ---
>   tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> index b5c3ddb90942..f0b36e7a152e 100644
> --- a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> +++ b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> @@ -23,10 +23,21 @@
>   #include <sys/mount.h>
>   #include <unistd.h>
>   
> +#include "../kselftest.h"
> +
>   int main(void)
>   {
>   	int fd;
>   
> +	/* Setting up kselftest framework */
> +	ksft_print_header();
> +	ksft_set_plan(1);
> +
> +	/* Check if test is run as root */
> +	if (geteuid()) {
> +		ksft_exit_fail_msg("Error : Need to run as root");

Use ksft_skip call.

> +	}
> +
>   	if (unshare(CLONE_NEWNS) == -1) {
>   		if (errno == ENOSYS || errno == EPERM) {
>   			fprintf(stderr, "error: unshare, errno %d\n", errno);

thanks,
-- Shuah


