Return-Path: <linux-kernel+bounces-272159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DA69457F6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655321F237F1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 06:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698AA42A99;
	Fri,  2 Aug 2024 06:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J2KvKbOC"
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D5638F9C
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 06:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722579216; cv=none; b=XiTMInJvZ+1QsDt/WDnjr1KK/b6kBsEhKpdj4Ei2P3bpZcBHdZpVmQDtuNp4w60RG3RC63AS7QhiKFMDakp3swY5RPuxsmj7gUa42QCXllEKrbkA8ObLIlyy5MqiZFEU7hXa3ut3q69Th3O6lREO45bVt7NkO6G575o5xojo/Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722579216; c=relaxed/simple;
	bh=7wlCz+/Kq2YN1j/IXKUZWDhXIvjM4wTF023RqQKRZlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTnOlzlryBvaWpGWwEZSz1JZJCdnbqmCnAZEW1YNL205XQsJQD3w1l1TuaiFnLtz+4tOZ0oVTAqUy/XVQYvPgZXEl2GRdCf14LHj5qZ2hOBIBSDt7gDGHmZCsSZ5dpoKCG9ERWkf8TRYMtwYgNoJUwwNy1WO++FwzrrzVtTBqXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J2KvKbOC; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5b5b67d0024so4302149a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 23:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722579212; x=1723184012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q/1Z5Rn3gKus7O9I2KHQuzF6OLvb+n+dFqmCow1dkgw=;
        b=J2KvKbOCMUDCgCYV0VEoDFEnhr3mz4N8OxzRFFJm97v+ZznhzcgUUghf+VPpTUjh6b
         m/VOmzWXhZIvz4j3MIUINk4PLqWMHVaxlLXYTUjYd8RnvQtRGPwkhtOpZAWI9DHxF9sO
         trjK5WEn7ymjpaasmkBV3tibdMDg3lGyQPAEQETF8XPi7enHkXo3jQYvg2CCxCDnu7aO
         XJNz66PRePeHAD1iNtlxtRcVfZkAE2w3K4RDhZFD2SkteI9h9Zy1nKZCMq0iHv214Wmw
         hfDHuZ9/re7nE76kQoK23dN0CqL0mHdfHc7Tl81HuwUeDRHlDP6Pxxfjtan89yrHSWcD
         AZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722579212; x=1723184012;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/1Z5Rn3gKus7O9I2KHQuzF6OLvb+n+dFqmCow1dkgw=;
        b=Fub7zTYmBe5poD7wNyDLKeERqDncSkPvXshX+611SrqI6zIEv9acBV0devo8Wg1+rm
         lXYbz/4tVgoRZx6EWx0BrwfSQeA7naz9iVWqYj48/QYsf53mGh4XCWfLFbrXiso8FDR5
         PYskZejGeoBekRiIK8ihBdyJSi7icD/JhK00+m5H180OfpZ113tvSI5+aSYBCjEDOuxd
         cQYBrwQd0qX41W8j+Ox3DjrRRQVY8HkY2ruN9ITpC2ipc08JBqENjZFq7BODzkJw6suJ
         6ZeWDzwuEJk7V4VxW9mYVurbazAaE4cX+izuUvzHdOK9qd7W+q2wM4ISBzc889qoBiMB
         EMJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcGRxCXCL6qxOt+JVF/THNQMM5GJo2JH9BsCBqEM2Xh0AsXn8e772fVvy8LpBBRv54920W45ITOYzPYkG4suGOUtGkO3hRXZNWffpt
X-Gm-Message-State: AOJu0YxBxi52/LlOq23gfmmoZDMm0x5KBQP5nCb3lEXVZe/BiH3XeRri
	0/vRGqh1DGUPgBq+lia3VnJ4P0V06gn9trlsCF8Tc+FtqQL3O/Qs9m3ksVaPekw=
X-Google-Smtp-Source: AGHT+IG7b5dSMQLA27l9A8T19BbU96oeHKjPQe7cmcMJyxRw07PCz5+OXnehgoGI+Yz3mYwymImUZA==
X-Received: by 2002:a17:907:9410:b0:a7a:8522:5eec with SMTP id a640c23a62f3a-a7dc509fd36mr183494066b.53.1722579211775;
        Thu, 01 Aug 2024 23:13:31 -0700 (PDT)
Received: from [192.168.1.59] ([151.51.15.217])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d515fesm57847266b.107.2024.08.01.23.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 23:13:31 -0700 (PDT)
Message-ID: <b0de5bc7-2b94-47cc-9610-fbec1347aecc@suse.com>
Date: Fri, 2 Aug 2024 08:13:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LTP] [PATCH v4 0/5] Add fchmodat2 testing suite
To: Petr Vorel <pvorel@suse.cz>, Aleksa Sarai <cyphar@cyphar.com>
Cc: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it,
 Alexey Gladkov <legion@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Cyril Hrubis <chrubis@suse.cz>,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 =?UTF-8?Q?Ga=C3=ABl_PORTAY?= <gael.portay@rtone.fr>,
 linux-kernel@vger.kernel.org
References: <20240801-fchmodat2-v4-0-7f2f11a53a09@suse.com>
 <20240801165756.GA1526142@pevik>
 <20240802.011554-broke.flocks.valiant.camp-sk9TjsxvPYf@cyphar.com>
 <20240802054252.GA1582980@pevik>
Content-Language: en-US
From: Andrea Cervesato <andrea.cervesato@suse.com>
In-Reply-To: <20240802054252.GA1582980@pevik>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

On 8/2/24 07:42, Petr Vorel wrote:
>> On 2024-08-01, Petr Vorel <pvorel@suse.cz> wrote:
>>> Hi all,
>>>> This is a patch-set that implements fchmodat2() syscall coverage.
>>>> fchmodat2() has been added in kernel 6.6 in order to support
>>>> AT_SYMLINK_NOFOLLOW and AT_EMPTY_PATH in fchmodat().
>>>> There's no man pages yet, so please take the following links as
>>>> main documentation along with kernel source code:
>>> I would hope that it'd be at least Christian's fork [1], but it's not there.
>>> I suppose nobody is working on the man page.
>>>> https://www.phoronix.com/news/fchmodat2-For-Linux-6.6
>>>> https://lore.kernel.org/lkml/20230824-frohlocken-vorabend-725f6fdaad50@brauner/
>>>> ***********
>>>> * WARNING *
>>>> ***********
>>>> fchmodat2_02 fails with EOPNOTSUPP because of missing feature.
>>> For a record, it's fchmodat2_01.c (from this patchset) which is failing (on
>>> 6.10.1-1.g4c78d6f-default Tumbleweed and 6.6.21-0-lts Alpine, both x86_64 VMs).
>>> Andrea, I would personally just skip test on EOPNOTSUPP (that's what we do in
>>> LTP on EOPNOTSUPP). The question why is not supported and whether is going to be
>>> fixed.
>>> Looking into glibc change 65341f7bbe ("linux: Use fchmodat2 on fchmod for flags
>>> different than 0 (BZ 26401)") one year old change from glibc-2.39 [2] it looks
>>> just accepted behavior (glibc returns EOPNOTSUPP on symlink):
>>> +  /* Some Linux versions with some file systems can actually
>>> +     change symbolic link permissions via /proc, but this is not
>>> +     intentional, and it gives inconsistent results (e.g., error
>>> +     return despite mode change).  The expected behavior is that
>>> +     symbolic link modes cannot be changed at all, and this check
>>> +     enforces that.  */
>>> +  if (S_ISLNK (st.st_mode))
>>> +    {
>>>         __close_nocancel (pathfd);
>>> -      return ret;
>>> +      __set_errno (EOPNOTSUPP);
>>> +      return -1;
>>> +    }
>>> Also musl also behaves the same on his fallback on old kernels [3]
>>> (it started 10 years ago on 0dc48244 ("work around linux's lack of flags
>>> argument to fchmodat syscall") when SYS_fchmodat was used and kept when this
>>> year SYS_fchmodat2 started to be used in d0ed307e):
>>> 	int ret = __syscall(SYS_fchmodat2, fd, path, mode, flag);
>>> 	if (ret != -ENOSYS) return __syscall_ret(ret);
>>> 	if (flag != AT_SYMLINK_NOFOLLOW)
>>> 		return __syscall_ret(-EINVAL);
>>> 	struct stat st;
>>> 	int fd2;
>>> 	char proc[15+3*sizeof(int)];
>>> 	if (fstatat(fd, path, &st, flag))
>>> 		return -1;
>>> 	if (S_ISLNK(st.st_mode))
>>> 		return __syscall_ret(-EOPNOTSUPP);
>
>>>> According to documentation, the feature has been implemented in
>>>> kernel 6.6, but __in reality__ AT_SYMLINK_NOFOLLOW is not working
>>>> on symbolic files. Also kselftests, which are meant to test the
>>>> functionality, are not working and they are treating fchmodat2()
>>>> syscall failure as SKIP. Please take a look at the following code
>>>> before reviewing:
>>>> https://github.com/torvalds/linux/blob/8f6a15f095a63a83b096d9b29aaff4f0fbe6f6e6/tools/testing/selftests/fchmodat2/fchmodat2_test.c#L123
>>> I see there is a kselftest workaround in 4859c257d295 ("selftests: Add fchmodat2
>>> selftest") [4], where fchmodat2 failure on symlink is simply skipped.
>>> Aleksa, you're probably aware of this fchmodat2() failure on symlinks. Does
>>> anybody work or plan to work on fixing it? LTP has policy to not cover kernel
>>> bugs, if it's not expected to be working we might just skip the test as well.
>> If I understand the bug report, the issue is that fchmodat2() doesn't
>> work on symlinks?
> Yes.
>
>> This is intentional -- Christian fixed a tree-wide bug a while ago[1]
>> where some filesystems would change the mode of symlinks despite
>> returning an error (usually EOPNOTSUPP) and IIRC a few others would
>> happily change the mode of symlinks.
> Ah, I've seen this in the past. Thanks a lot for reminding me.
>
>> The current intended behaviour is to always return EOPNOTSUPP, and AFAIK
>> there is no plan to re-enable the changing of symlink modes. EOPNOTSUPP
>> was chosen because that's what filesystems were already returning.
>> (While this is a little confusing, VFS syscalls return EINVAL for an
>> unsupported flag, not EOPNOTSUPP.)
>> The benefit of an AT_SYMLINK_NOFOLLOW flag is not just to to allow a
>> syscall to operate on symlinks, it also allows programs to safely
>> operate on path components without worrying about symlinks being
>> followed (this is relevant for container runtimes, where we are
>> operating on untrusted filesystem roots -- though in the case of
>> fchmodat2(2) you would probably just use AT_EMPTY_PATH in practice). So
>> an error here is actually what you want as a program that uses
>> AT_SYMLINK_NOFOLLOW (since the actual operation is intentionally not
>> supported by filesystems).
Thanks for the explanation. I also have a question around this topic: 
AT_SYMLINK_NOFOLLOW has been added in order to avoid symlinks being 
followed. But if filesystems are not supporting it, why do we have this 
feature? Also, is it an unsupported feature only on certain filesystems?
> Thanks a lot for explaining the background!
>
>> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5d1f903f75a80daa4dfb3d84e114ec8ecbf29956
>>> I see a RFC UAPI related patchset [5] which touches include/uapi/linux/fcntl.h,
>>> but AFAIK it's not related to this problem.
>> Yeah this is unrelated, that patch is about clarifying how AT_* flags
>> are allocated, not syscall behaviour.
> Thanks!
>
>>> Kind regards,
>>> Petr
> @Andrea, I guess we want something like this:
>
> +++ testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
> @@ -43,9 +43,10 @@ static void test_symbolic_link(void)
>   	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
>   	verify_mode(fd_dir, SNAME, S_IFLNK | 0777);
>   
> -	TST_EXP_PASS(fchmodat2(fd_dir, SNAME, 0640, AT_SYMLINK_NOFOLLOW));
> -	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
> -	verify_mode(fd_dir, SNAME, S_IFLNK | 0640);
> +	if (tst_kvercmp(6, 6, 0) >= 0) {
> +		TST_EXP_FAIL(tst_syscall(__NR_fchmodat2, fd_dir, SNAME, 0640,
> +					 AT_SYMLINK_NOFOLLOW), EOPNOTSUPP);
> +	}
>   }
>   
>   static void test_empty_folder(void)

I think it makes more sense to filter out only filesystems which are not 
supporting this feature (see my comment above).

Best regards,
Andrea


