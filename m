Return-Path: <linux-kernel+bounces-335807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C0B97EB05
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A561C21360
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13866197A72;
	Mon, 23 Sep 2024 11:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="N+PO99so"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782F280038
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727092179; cv=none; b=iNWYn+sibhRfbxvil8ta/CGX/7d/gyl9RsDpwFHRZSXnEVTxzSkOghwTKqYSltMilImA22ldn8xBUm/I6y+9w/+P1wrla5kuc9C3eKAU/eMnlNvNgIH/J20IrYI9dS2SKpJqTxl/32qUGu4hi6aMN9fJSjrxZ1gvr4zwAuDJMb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727092179; c=relaxed/simple;
	bh=FNuIvI5yetUYWxbZVVyMaiZIm82W0BZVAaRwRbmZS4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=audQ9WSc7Pb6JeBWenMPjTtU3WWCmQmJdZQDIiRdTuRXq8CZ46mK6viypXzVrV/Bf/4O37q1nRvrREEySQ8j9evPZIeYVTY38lSx2znirEV9AQeXpQrBSbbeHHsrJ6MW/fuovGf+6gtygEe3y1vWisnndpn9095e5sXbBZYi8a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=N+PO99so; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ddd758aaf4so29385977b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 04:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727092175; x=1727696975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAlESk6wiDi0M4YJzyLEruJppHMKW1SuMG7aPcq9FG4=;
        b=N+PO99sokRkG+ATvRgJL7mWB/y5+Ym2+iRY4qwxpJ2h8bcUbiGrx1MrByCFC1OCy9y
         Eb+/uSxf8HoCb+VrqQ2kh5/eUXhzJtgLhUQ0AVrymyJzfDV0bMCM1wZNBuaVSoMtr9BB
         C/UOt0Syk5YEl7STHl0VU61JviA8QD6pzAzgxjm0L4OYjZ3EcYlHEMo0gN66KNg2MABd
         wqZ89nJPrqRx/tyWzlskgA5pQvozv0x921h0HPjbkArv5XaJhtn7zcM6Tn9vxxzsp0CH
         gwRmf+CDrhyjeXVnQ7HQj80dtZBfW2GQoWkFLyGFoCP8AqCfRMizzhQTmHPUu2asnKPF
         9ZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727092175; x=1727696975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAlESk6wiDi0M4YJzyLEruJppHMKW1SuMG7aPcq9FG4=;
        b=VUGOipJ98Ub7dwRUVFhscui5aFEHZYNi/7n6OEnKfeg4ZZ3llDWwHi6nrT6nK54NJg
         VCicLPLbmYHN679f+6Grj69FFgK9xPHe0d59F6QoCSKoZILIdLX/GtHUqNAf223rA2cE
         02V13dsNoMPYsZcB2B5v6OEdd+/TWGEqMotlHVXnLJ7yVbVYCR6XP65yplZTFlVdSG1P
         ko/Vo6Nd3L0jtWvdij+TKQ4ZVDch2clIOZqmvuynU/FS1cQYDSXfWBeH+JFy1LgHD9L3
         RCKsT9EO/dxaADVL8JAzQKwvcgiAccXUoDnxw1fl1hcAelMMybTIxILUPI452D73DEVx
         74GQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh7HC674TDDG7uUS7qD6MBX2ayNxoR6IW7lkzb2eqOI9RsTN7qBIK50sVewzrTwyA9Tb1WoqC2+RRynVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD+ZCadYLuQRBsOGeRmSYGSckXAYOMm84bdq9Ji/ZNpHPJcGc+
	t20AkeVzsz7MVUUzxue1C9Yf1zISHvw4C8ZL78dynx5sokWbDON2BHKcFrPru0Ms/+0awEd1+ZH
	0t7cjZAO3hvaLLPi71t2/Ix/i5ebrOwoDdS+CzQqnfTcRjz8Ylg==
X-Google-Smtp-Source: AGHT+IEWUMDhWZbDPVnXlsv492mq+DG3vADXokcLji3X/LgPO/+OVuuFhQ5r0QWl83od0sqQXdBQ0yhgEMu/H7USDEc=
X-Received: by 2002:a05:690c:2c0d:b0:6dd:c764:2d5a with SMTP id
 00721157ae682-6dfeeffff81mr64609897b3.41.1727092175387; Mon, 23 Sep 2024
 04:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923115252.3562956-1-ruanjinjie@huawei.com>
In-Reply-To: <20240923115252.3562956-1-ruanjinjie@huawei.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Sep 2024 07:49:24 -0400
Message-ID: <CAHC9VhRN2rsJOHYgVMeG=9X1htCCgNQc_XB_jJY-Ruu-BrtFQA@mail.gmail.com>
Subject: Re: [PATCH] ipe: Fix out-of-bound access of kunit_suite_num_test_cases()
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: wufan@linux.microsoft.com, jmorris@namei.org, serge@hallyn.com, 
	deven.desai@linux.microsoft.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 7:42=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
> Currently, there is no terminator entry for ipe_parser_test_cases,
> hence facing below KASAN warning,
>
>         BUG: KASAN: global-out-of-bounds in kunit_suite_num_test_cases+0x=
b4/0xcc
>         Read of size 8 at addr ffffffe21035fec0 by task swapper/0/1
>
>         CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Tainted: G                 N=
 6.11.0+ #327
>         Tainted: [N]=3DTEST
>         Hardware name: linux,dummy-virt (DT)
>         Call trace:
>          dump_backtrace+0x94/0xec
>          show_stack+0x18/0x24
>          dump_stack_lvl+0x90/0xd0
>          print_report+0x1f4/0x5b4
>          kasan_report+0xc8/0x110
>          __asan_report_load8_noabort+0x20/0x2c
>          kunit_suite_num_test_cases+0xb4/0xcc
>          attr_module_get+0x54/0xc0
>          kunit_print_attr+0x234/0x358
>          kunit_run_tests+0x138/0xbf4
>          __kunit_test_suites_init+0x110/0x1d0
>          kunit_run_all_tests+0x358/0x394
>          kernel_init_freeable+0x488/0x61c
>          kernel_init+0x24/0x1e4
>          ret_from_fork+0x10/0x20
>
>         The buggy address belongs to the variable:
>          ipe_parser_test_cases+0x60/0x1ba0
>
>         The buggy address belongs to the virtual mapping at
>          [ffffffe20ffe0000, ffffffe2120c1000) created by:
>          paging_init+0x474/0x60c
>
>         The buggy address belongs to the physical page:
>         page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pf=
n:0x4535f
>         flags: 0x3fffe0000002000(reserved|node=3D0|zone=3D0|lastcpupid=3D=
0x1ffff)
>         raw: 03fffe0000002000 fffffffec014d7c8 fffffffec014d7c8 000000000=
0000000
>         raw: 0000000000000000 0000000000000000 00000001ffffffff 000000000=
0000000
>         page dumped because: kasan: bad access detected
>
>         Memory state around the buggy address:
>          ffffffe21035fd80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0
>          ffffffe21035fe00: 00 00 00 00 00 f9 f9 f9 f9 f9 f9 f9 00 00 00 0=
0
>         >ffffffe21035fe80: 00 00 00 00 00 00 00 00 f9 f9 f9 f9 00 00 00 0=
0
>                                                    ^
>          ffffffe21035ff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0
>          ffffffe21035ff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0
>         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Add a dummy terminator entry at the end to assist
> kunit_suite_num_test_cases() in traversing up to the terminator entry
> without accessing an out-of-boundary index.
>
> Fixes: 10ca05a76065 ("ipe: kunit test for parser")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  security/ipe/policy_tests.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks, I just saw this reported last night with the same patch/fix,
lore link below.  I'm giving it a few hours for Fan to come online and
ACK the patch, but if I don't hear from Fan by this afternoon I'll
merge it and send it up to Linus.

https://lore.kernel.org/linux-security-module/20240922145226.491815-1-linux=
@roeck-us.net/

> diff --git a/security/ipe/policy_tests.c b/security/ipe/policy_tests.c
> index 89521f6b9994..0725fe36f8bb 100644
> --- a/security/ipe/policy_tests.c
> +++ b/security/ipe/policy_tests.c
> @@ -286,6 +286,7 @@ static void ipe_parser_widestring_test(struct kunit *=
test)
>  static struct kunit_case ipe_parser_test_cases[] =3D {
>         KUNIT_CASE_PARAM(ipe_parser_unsigned_test, ipe_policies_gen_param=
s),
>         KUNIT_CASE(ipe_parser_widestring_test),
> +       {}
>  };
>
>  static struct kunit_suite ipe_parser_test_suite =3D {
> --
> 2.34.1

--=20
paul-moore.com

