Return-Path: <linux-kernel+bounces-196674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AB08D5FBD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483F91C2195A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEA5155A5D;
	Fri, 31 May 2024 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eR812KRI"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E82E155740
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 10:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717151379; cv=none; b=tA1wyyI5Ebm0ambkMsGFcc0MBXxq9PHHZNqYL2Cfzct4LGUjTf1z6YYCMJAlkSpKX5w3abn09yR6/HbIyLjYDSGr5aRnywY2NaHyQhqaZaI9lZF7XvWBN3jlw2TNXP0kvnpgT71zBUw/Yp6m5jkvjrJCCovF1DpMgPPC+f3xL44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717151379; c=relaxed/simple;
	bh=d6XmU4MkT31pbR7XW+eraoqZKY9aXecz75Ro30rl9E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJcPvp32JiZae1YHkW55j5JhyTn752uMK8BL842GtL/B3PVHTCpOU9CU6mzGu6R2yp6Q9DSAvcb6s24Y2W9J4rqqoh892IVHrWum3wWQ+BbBGzp0DEwAP64hFHzfwSg5bzSkdHsFuhCC2SQHhrat4EtPZG5O+VPYRYw8rkopCX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eR812KRI; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a32b0211aso782362a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 03:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717151376; x=1717756176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u/FNFGS+Elt6U2vX4/w507NMHfT9f3pQijeIbOb8B/s=;
        b=eR812KRICoWbxdZjWVvXkEL0YQwMDB2zyvX9bEQhDRAYvaq9LUpv4IWS/aunKk/S9a
         xlOnqC/qnTN2MeYsoh6gA11e+GS8aFoK3iLi54LLoOVQTODqVaxxs2uIUnF3Z7zzrYmP
         1SG8tcyB0Yy3MFkqvWvqUoWciRuFFYWcWlcxb3j6+t70lAvMVgLaeJzUQoszJsOuwXpb
         N7W1cPLTk+D5iZDXzTPEK7z9zcul2jmVR8MUCZ1SEOeFrJ+BFIZppi23GAW5CB7ISDL8
         LKGT5vJCYiP4TEYePvk1y82YFWaY4LtyBNAAFaxwAQ/PJWc6lLFrF/u7BmPzaWBW6oJ9
         jYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717151376; x=1717756176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/FNFGS+Elt6U2vX4/w507NMHfT9f3pQijeIbOb8B/s=;
        b=FFBvrShbyvgwRvT6QnoRLURABuBaFMXztzfL+ySusZPUF7lPSk/69rnu9l401hixEn
         FysRBiEIABSMj1e9PBI5kovpaIDyUQzjFwHwLrhpX8i5psJ1Tq109cLeCA5hTAn0d2g6
         4IxYre8IBYxwsQL56frTwzS9y56065/U8Rq/hd1GYLL4F/h9kbb8LL3lGG60Uywdaeeu
         2ZWLboTVvElRkw1xlfd5Ga56eqnK+c3yYkUItvNg85SHAHRtnURu308i9r/FR+zcGEqQ
         /DHNDQ02ozBC0f9AXVSDTBX9W1xhp5H3y3Z80YmSVxbr5oyn27JOcDSeOr8TTw0Q5xuj
         2Egg==
X-Forwarded-Encrypted: i=1; AJvYcCVb23JNN+86WyQGf2nkZVHS7uIjd0aMdb/sPdnLcjLPDs1ux405XemW5C363vzQzzYIplaB7i5xdi7RfsdEiRjpUUCRkKSAhh20TyDZ
X-Gm-Message-State: AOJu0YxWkNZtiqFi4zVuXb23+I9RTQetGUkxs6cB+LZDsapQxNKNhQP8
	9ktNAq/UnynOvdYRhQa3JT6YJf0KyK3ifvRva9e8lhH0C3EzgxQ7
X-Google-Smtp-Source: AGHT+IGfpZ7/uKrUeN1LFsgryJlum7lJMPwV4JLgFMb7zoCdyk29q8/vID7JhYvWd8yl5yODU+qO5A==
X-Received: by 2002:a17:906:6091:b0:a66:e009:eb56 with SMTP id a640c23a62f3a-a682022caffmr84050066b.24.1717151375639;
        Fri, 31 May 2024 03:29:35 -0700 (PDT)
Received: from f (cst-prg-8-232.cust.vodafone.cz. [46.135.8.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67eb3444bfsm71394366b.201.2024.05.31.03.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 03:29:34 -0700 (PDT)
Date: Fri, 31 May 2024 12:29:21 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: Hugh Dickins <hughd@google.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Jan Kara <jack@suse.cz>, Tim Chen <tim.c.chen@intel.com>, 
	Dave Chinner <dchinner@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Carlos Maiolino <cem@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Subject: Re: [linus:master] [shmem,percpu_counter]  beb9868628:
 BUG:KCSAN:data-race_in__percpu_counter_limited_add/__percpu_counter_limited_add
Message-ID: <pw76mywfp3o6j3oleqlujejnptd465deydcigypppweqim5uam@nswbchgueaz3>
References: <202405311100.d46f2cc1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202405311100.d46f2cc1-lkp@intel.com>

On Fri, May 31, 2024 at 01:52:40PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:KCSAN:data-race_in__percpu_counter_limited_add/__percpu_counter_limited_add" on:
> 
> commit: beb9868628445306958fd7b2da1cd369a4a381cc ("shmem,percpu_counter: add _limited_add(fbc, limit, amount)")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master      2bfcfd584ff5ccc8bb7acde19b42570414bf880b]
> [test failed on linux-next/master 6dc544b66971c7f9909ff038b62149105272d26a]
> 
> in testcase: trinity
> version: 
> with following parameters:
> 
> 	runtime: 300s
> 	group: group-01
> 	nr_groups: 5
> 
> 
> 
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> in our tests,
>   dmesg.BUG:KCSAN:data-race_in__percpu_counter_limited_add/__percpu_counter_limited_add
> does not always happen, 88 times out of 150 runs as below.
> 
> 
> 3022fd7af9604d44 beb9868628445306958fd7b2da1
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :60         147%          88:150   dmesg.BUG:KCSAN:data-race_in__percpu_counter_limited_add/__percpu_counter_limited_add
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202405311100.d46f2cc1-lkp@intel.com
> 
> 
> 
> [  301.127451][ T4651] ==================================================================
> [  301.128485][ T4651] BUG: KCSAN: data-race in __percpu_counter_limited_add / __percpu_counter_limited_add
> [  301.129715][ T4651]
> [  301.130014][ T4651] write to 0xffff88810ffc3450 of 8 bytes by task 4674 on cpu 0:
> [ 301.130981][ T4651] __percpu_counter_limited_add (lib/percpu_counter.c:325) 
> [ 301.131692][ T4651] shmem_inode_acct_blocks (mm/shmem.c:220) 
> [ 301.132319][ T4651] shmem_get_folio_gfp+0x3a9/0x750 
> [ 301.133054][ T4651] shmem_write_begin (mm/shmem.c:2135 mm/shmem.c:2692) 
> [ 301.133690][ T4651] generic_perform_write (mm/filemap.c:3962) 
> [ 301.134347][ T4651] shmem_file_write_iter (mm/shmem.c:2868) 
> [ 301.134956][ T4651] do_iter_readv_writev (include/linux/fs.h:1956 fs/read_write.c:735) 
> [ 301.135628][ T4651] do_iter_write (fs/read_write.c:860) 
> [ 301.136178][ T4651] vfs_writev (fs/read_write.c:933) 
> [ 301.136716][ T4651] __x64_sys_pwritev2 (fs/read_write.c:1030 fs/read_write.c:1089 fs/read_write.c:1080 fs/read_write.c:1080) 
> [ 301.139719][ T4651] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
> [ 301.140316][ T4651] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
> [  301.141129][ T4651]
> [  301.141465][ T4651] read to 0xffff88810ffc3450 of 8 bytes by task 4651 on cpu 1:
> [ 301.142436][ T4651] __percpu_counter_limited_add (lib/percpu_counter.c:302 (discriminator 1)) 
> [ 301.143222][ T4651] shmem_inode_acct_blocks (mm/shmem.c:220) 
> [ 301.143931][ T4651] shmem_get_folio_gfp+0x3a9/0x750 
> [ 301.144696][ T4651] shmem_write_begin (mm/shmem.c:2135 mm/shmem.c:2692) 
> [ 301.145370][ T4651] generic_perform_write (mm/filemap.c:3962) 
> [ 301.146112][ T4651] shmem_file_write_iter (mm/shmem.c:2868) 
> [ 301.146697][ T4651] do_iter_readv_writev (include/linux/fs.h:1956 fs/read_write.c:735) 
> [ 301.147330][ T4651] do_iter_write (fs/read_write.c:860) 
> [ 301.147918][ T4651] vfs_writev (fs/read_write.c:933) 
> [ 301.148480][ T4651] __x64_sys_pwritev2 (fs/read_write.c:1030 fs/read_write.c:1089 fs/read_write.c:1080 fs/read_write.c:1080) 
> [ 301.149047][ T4651] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
> [ 301.149629][ T4651] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
> [  301.150358][ T4651]
> [  301.150643][ T4651] value changed: 0x0000000000059e35 -> 0x0000000000059e56
> [  301.151483][ T4651]
> [  301.151778][ T4651] Reported by Kernel Concurrency Sanitizer on:
> [  301.152559][ T4651] CPU: 1 PID: 4651 Comm: trinity-c7 Not tainted 6.6.0-rc4-00235-gbeb986862844 #1
> [  301.153676][ T4651] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [  301.154962][ T4651] ==================================================================
> 

This is the bug I described in my mail:
https://lore.kernel.org/linux-mm/5eemkb4lo5eefp7ijgncgogwmadyzmvjfjmmmvfiki6cwdskfs@hi2z4drqeuz6/

write side:
        if (good) {
                count = __this_cpu_read(*fbc->counters);
                fbc->count += count + amount; <---- line 325
                __this_cpu_sub(*fbc->counters, count);
        }


read side:
        /* Skip taking the lock when safe */
        if (abs(count + amount) <= batch &&
            fbc->count + unknown <= limit) { <---- line 302
                this_cpu_add(*fbc->counters, amount);
                local_irq_restore(flags);
                return true;
        }


As described in the e-mail I don't believe the existence of the routine
is warranted to begin with.

> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240531/202405311100.d46f2cc1-lkp@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

