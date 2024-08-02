Return-Path: <linux-kernel+bounces-272258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 855C594595A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE16286C54
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AEF1C0DC4;
	Fri,  2 Aug 2024 07:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NOGyFL+F"
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E441BF338
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722585508; cv=none; b=m/qdHsplTZMBpSK1YnErwJTSUJvEiqFkTMSjff79Up+XypP+hAkDZQK0tn0pIcPjyxll4TK1tAgkU1zHzJFURrRzJP8PvynUgNXGPz9+0T6YrCF6uEsH5Iv2RIej9xPF4EBufB6uXkCmTO4rgBGuZ3X8eYB1ejt+ZUHSfqzKhaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722585508; c=relaxed/simple;
	bh=DrziQ3tQ1fdNYM+4Dc5NbDvqnsZfmblpHQeI6CU8SSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M/8AYW8tcOxJXovFGR3NUKHbDWVmTwCL9QvUl0dN+SVktA2rHcB1ibc9QgfwYS57EqHN8EQYUNMsRlGY3msX2ald1L4OHQQ2lPx2PwyrMBXGpCkukj3hkN7VsPIjXXhofVSfzOMF+XASmeMEGdaAjow8Mf7N2T9qkJ5Uyc6q2UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NOGyFL+F; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3684eb5be64so4429323f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 00:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722585505; x=1723190305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FD9R99ybC/DMsbNQ/rxFayZFlcWsSwSls1oRsOgDDl4=;
        b=NOGyFL+FSux5s4ILfs4+9WP441/1fDtI4IlAnG2GwAaleFN+S3pngxWmR9vVGaGSn6
         pcKK2k6ATDE1ONs2quUCjm8pvYOhOdyEMrndmZiBnxOjVG8RokKXlASDS0AgrI+Zt8xx
         xE7uBk3Y0VTL4JNrxvNjX2kuW5jxK+DqAIxznlpDFE6/EBFMg+oHj6yUVkU3ce0AkTDa
         4DN3eDxWLAEIJQWIPKofFXK95+0lZKOunRkXrrWJRNDa1+2/NmVjx02MfSIFOVIZHrrj
         CWN2bAJtpEtKjO1ivp0RCNeGnYy+tGmE0OX6dfDT/dSfUnN8wV59oraZ77roR5Oi6ESm
         ry3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722585505; x=1723190305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FD9R99ybC/DMsbNQ/rxFayZFlcWsSwSls1oRsOgDDl4=;
        b=NgYKV/61R7b60/ErwfESn8C284Gcc+gGRLyGQSM+dEPjw1CA0UqlhrQdD1yLwqNHDX
         Dxwo6ZM2DloO5pRv62VvxO40ghD4k8kyrQLaO7af91o0zW+qSDT0cM3Wqela/KrqtZNb
         Owu3yiKRTZetIXKbhzhD/rIS2XUeHafx3J/dIHzvRsl0kgkkV55cebigIk9TxMZLb05o
         rWgraboU5Jy1VfKCftLBSoMqBhQxSjcDavS2nJgsNQ6lAsOw9ildt0XX/jo0xed+VHw8
         kGGm+M8ee54q+2BHLW92TSmmlizoQ8Z2C13eZbHza0FtOPlv9/JPsljs4b1feHe9pkgw
         dkKg==
X-Forwarded-Encrypted: i=1; AJvYcCVq/OZJqRKYtZuMibDdIoz9Jf1sCQ21mBJ2APQFaJZZ+YJN4FD0g8D4JAzdQakw8jkv4VufaRzjQT/uDZ7cn7F0LiuQwJJeHY/wKHmc
X-Gm-Message-State: AOJu0YwsYF12qxcQJLd/4MUBXGfWB/5PJrDjW8rQszT8KBk0yqs8oArm
	/JZnfS/C26bAm8Dnc5+M3Bnkh1RKiPfGYW412izkOarpiwdHR9wwNNP4cbbBs1g=
X-Google-Smtp-Source: AGHT+IEmOL2nniedOG75wzDqiUBVdguoVwPD1B+InPRrABQRIUx1D8nOPXkDqFaP0l/O8hEPdBL+qw==
X-Received: by 2002:a05:6000:1fa2:b0:368:7ee2:b7c8 with SMTP id ffacd0b85a97d-36bbc0e6721mr1658442f8f.1.1722585504181;
        Fri, 02 Aug 2024 00:58:24 -0700 (PDT)
Received: from [192.168.1.59] ([151.51.15.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf0cbdbsm1301380f8f.13.2024.08.02.00.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 00:58:23 -0700 (PDT)
Message-ID: <bedfd109-8848-43a8-8bf5-6ef3f1334f1c@suse.com>
Date: Fri, 2 Aug 2024 09:58:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LTP] [PATCH v4 0/5] Add fchmodat2 testing suite
To: Petr Vorel <pvorel@suse.cz>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
 Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it,
 Alexey Gladkov <legion@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Cyril Hrubis <chrubis@suse.cz>,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 =?UTF-8?Q?Ga=C3=ABl_PORTAY?= <gael.portay@rtone.fr>,
 linux-kernel@vger.kernel.org
References: <20240801-fchmodat2-v4-0-7f2f11a53a09@suse.com>
 <20240801165756.GA1526142@pevik>
 <20240802.011554-broke.flocks.valiant.camp-sk9TjsxvPYf@cyphar.com>
 <20240802054252.GA1582980@pevik>
 <b0de5bc7-2b94-47cc-9610-fbec1347aecc@suse.com>
 <20240802074948.GA1595727@pevik>
Content-Language: en-US
From: Andrea Cervesato <andrea.cervesato@suse.com>
In-Reply-To: <20240802074948.GA1595727@pevik>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/2/24 09:49, Petr Vorel wrote:
>> Hi!
>> On 8/2/24 07:42, Petr Vorel wrote:
>>>> On 2024-08-01, Petr Vorel <pvorel@suse.cz> wrote:
>>>>> Hi all,
>>>>>> This is a patch-set that implements fchmodat2() syscall coverage.
>>>>>> fchmodat2() has been added in kernel 6.6 in order to support
>>>>>> AT_SYMLINK_NOFOLLOW and AT_EMPTY_PATH in fchmodat().
>>>>>> There's no man pages yet, so please take the following links as
>>>>>> main documentation along with kernel source code:
>>>>> I would hope that it'd be at least Christian's fork [1], but it's not there.
>>>>> I suppose nobody is working on the man page.
>>>>>> https://www.phoronix.com/news/fchmodat2-For-Linux-6.6
>>>>>> https://lore.kernel.org/lkml/20230824-frohlocken-vorabend-725f6fdaad50@brauner/
>>>>>> ***********
>>>>>> * WARNING *
>>>>>> ***********
>>>>>> fchmodat2_02 fails with EOPNOTSUPP because of missing feature.
>>>>> For a record, it's fchmodat2_01.c (from this patchset) which is failing (on
>>>>> 6.10.1-1.g4c78d6f-default Tumbleweed and 6.6.21-0-lts Alpine, both x86_64 VMs).
>>>>> Andrea, I would personally just skip test on EOPNOTSUPP (that's what we do in
>>>>> LTP on EOPNOTSUPP). The question why is not supported and whether is going to be
>>>>> fixed.
>>>>> Looking into glibc change 65341f7bbe ("linux: Use fchmodat2 on fchmod for flags
>>>>> different than 0 (BZ 26401)") one year old change from glibc-2.39 [2] it looks
>>>>> just accepted behavior (glibc returns EOPNOTSUPP on symlink):
>>>>> +  /* Some Linux versions with some file systems can actually
>>>>> +     change symbolic link permissions via /proc, but this is not
>>>>> +     intentional, and it gives inconsistent results (e.g., error
>>>>> +     return despite mode change).  The expected behavior is that
>>>>> +     symbolic link modes cannot be changed at all, and this check
>>>>> +     enforces that.  */
>>>>> +  if (S_ISLNK (st.st_mode))
>>>>> +    {
>>>>>          __close_nocancel (pathfd);
>>>>> -      return ret;
>>>>> +      __set_errno (EOPNOTSUPP);
>>>>> +      return -1;
>>>>> +    }
>>>>> Also musl also behaves the same on his fallback on old kernels [3]
>>>>> (it started 10 years ago on 0dc48244 ("work around linux's lack of flags
>>>>> argument to fchmodat syscall") when SYS_fchmodat was used and kept when this
>>>>> year SYS_fchmodat2 started to be used in d0ed307e):
>>>>> 	int ret = __syscall(SYS_fchmodat2, fd, path, mode, flag);
>>>>> 	if (ret != -ENOSYS) return __syscall_ret(ret);
>>>>> 	if (flag != AT_SYMLINK_NOFOLLOW)
>>>>> 		return __syscall_ret(-EINVAL);
>>>>> 	struct stat st;
>>>>> 	int fd2;
>>>>> 	char proc[15+3*sizeof(int)];
>>>>> 	if (fstatat(fd, path, &st, flag))
>>>>> 		return -1;
>>>>> 	if (S_ISLNK(st.st_mode))
>>>>> 		return __syscall_ret(-EOPNOTSUPP);
>>>>>> According to documentation, the feature has been implemented in
>>>>>> kernel 6.6, but __in reality__ AT_SYMLINK_NOFOLLOW is not working
>>>>>> on symbolic files. Also kselftests, which are meant to test the
>>>>>> functionality, are not working and they are treating fchmodat2()
>>>>>> syscall failure as SKIP. Please take a look at the following code
>>>>>> before reviewing:
>>>>>> https://github.com/torvalds/linux/blob/8f6a15f095a63a83b096d9b29aaff4f0fbe6f6e6/tools/testing/selftests/fchmodat2/fchmodat2_test.c#L123
>>>>> I see there is a kselftest workaround in 4859c257d295 ("selftests: Add fchmodat2
>>>>> selftest") [4], where fchmodat2 failure on symlink is simply skipped.
>>>>> Aleksa, you're probably aware of this fchmodat2() failure on symlinks. Does
>>>>> anybody work or plan to work on fixing it? LTP has policy to not cover kernel
>>>>> bugs, if it's not expected to be working we might just skip the test as well.
>>>> If I understand the bug report, the issue is that fchmodat2() doesn't
>>>> work on symlinks?
>>> Yes.
>>>> This is intentional -- Christian fixed a tree-wide bug a while ago[1]
>>>> where some filesystems would change the mode of symlinks despite
>>>> returning an error (usually EOPNOTSUPP) and IIRC a few others would
>>>> happily change the mode of symlinks.
>>> Ah, I've seen this in the past. Thanks a lot for reminding me.
>>>> The current intended behaviour is to always return EOPNOTSUPP, and AFAIK
>>>> there is no plan to re-enable the changing of symlink modes. EOPNOTSUPP
>>>> was chosen because that's what filesystems were already returning.
>>>> (While this is a little confusing, VFS syscalls return EINVAL for an
>>>> unsupported flag, not EOPNOTSUPP.)
>>>> The benefit of an AT_SYMLINK_NOFOLLOW flag is not just to to allow a
>>>> syscall to operate on symlinks, it also allows programs to safely
>>>> operate on path components without worrying about symlinks being
>>>> followed (this is relevant for container runtimes, where we are
>>>> operating on untrusted filesystem roots -- though in the case of
>>>> fchmodat2(2) you would probably just use AT_EMPTY_PATH in practice). So
>>>> an error here is actually what you want as a program that uses
>>>> AT_SYMLINK_NOFOLLOW (since the actual operation is intentionally not
>>>> supported by filesystems).
>> Thanks for the explanation. I also have a question around this topic:
>> AT_SYMLINK_NOFOLLOW has been added in order to avoid symlinks being
>> followed. But if filesystems are not supporting it, why do we have this
>> feature?
> @Aleksa please correct me if I'm wrong.
>
> AFAIK (reading 5d1f903f75a8 commit message [1] and Aleksa's comments) previously
> it was an idea which many of the filesystem implemented wrongly - a mess
> regardless whether supported by the filesystem or not. I particularly like
> changing the mode but fail EOPNOTSUPP. And because glibc and musl did EOPNOTSUPP
> anyway (I found that as well), the best was just to follow this in kernel and
> unify all filesystems behavior by disabling this in VFS.
>
>> Also, is it an unsupported feature only on certain filesystems?
> Disabled in VFS => unsupported on all filesystems.
Ah right, that's quite obvious indeed.
>>> Thanks a lot for explaining the background!
>>>> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5d1f903f75a80daa4dfb3d84e114ec8ecbf29956
>>>>> I see a RFC UAPI related patchset [5] which touches include/uapi/linux/fcntl.h,
>>>>> but AFAIK it's not related to this problem.
>>>> Yeah this is unrelated, that patch is about clarifying how AT_* flags
>>>> are allocated, not syscall behaviour.
>>> Thanks!
>>>>> Kind regards,
>>>>> Petr
>>> @Andrea, I guess we want something like this:
>>> +++ testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
>>> @@ -43,9 +43,10 @@ static void test_symbolic_link(void)
>>>    	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
>>>    	verify_mode(fd_dir, SNAME, S_IFLNK | 0777);
>>> -	TST_EXP_PASS(fchmodat2(fd_dir, SNAME, 0640, AT_SYMLINK_NOFOLLOW));
>>> -	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
>>> -	verify_mode(fd_dir, SNAME, S_IFLNK | 0640);
>>> +	if (tst_kvercmp(6, 6, 0) >= 0) {
>>> +		TST_EXP_FAIL(tst_syscall(__NR_fchmodat2, fd_dir, SNAME, 0640,
>>> +					 AT_SYMLINK_NOFOLLOW), EOPNOTSUPP);
>>> +	}
>>>    }
>>>    static void test_empty_folder(void)
>> I think it makes more sense to filter out only filesystems which are not
>> supporting this feature (see my comment above).
> Due disabled in VFS since 5d1f903f75a8 all filesystems fail with EOPNOTSUPP,
> thus failure in LTP (TBROK), which needs to be handled.  Before 5d1f903f75a8
> some of them actually changed the mode (e.g. btrfs, ext4, xfs), but that's no
> longer the case. And because it got backported to all stable/LTS, we can expect
> this is the correct behavior.
>
> Kind regards,
> Petr
>
>> Best regards,
>> Andrea

I guess we can just assume EOPNOTSUPP for the test. I will add the .tag 
and errno check.

Thanks,
Andrea


