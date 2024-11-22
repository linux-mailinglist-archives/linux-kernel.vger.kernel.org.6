Return-Path: <linux-kernel+bounces-418372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DEA9D60ED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B60FB292B5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 14:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8751BCA02;
	Fri, 22 Nov 2024 14:54:08 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4F513B298
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732287248; cv=none; b=KkoLKiuo/gFLrjtZBDoOBb9MJjNOfVBCH+TlGLfQhJS0acIrRgAqOhvoXEObcEN2+H8l6RdczYP4MMll5ximV/7UceGsUukjsjKp4sJe3zU42dE/P2JfQC+ZKYKLXUIsXFaLz5bPjEOgqXsx75ZcS+ZxBz64yS9UHAqiAsIcLho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732287248; c=relaxed/simple;
	bh=QVy/1XkB1RqI0zvpm8rKiO0UAG8yi3ndNGtakNbq1YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=csDcdA8Plxm8rlGmi9gWNLvF/xNu56holo8n1sP9Zo4i2EvS0lp1KvCQ5iS60yyASMnQF0H+eGdLMPhyWekx7Zd1XxwFpEg273yJOlVYPTEcQB+DmKE1b+aZpjw8NoZNhqVIO3fmIJEK40j0YM/OYFr3KpKG2Kr26IBJUxD88eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 4AMErl8d006475;
	Fri, 22 Nov 2024 23:53:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 4AMErkXM006467
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 22 Nov 2024 23:53:46 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e0a6a2b5-acff-4b58-9457-292864a5bc91@I-love.SAKURA.ne.jp>
Date: Fri, 22 Nov 2024 23:53:47 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [tomoyo] c5e3cdbf2a: Kernel_panic-not_syncing:STOP
To: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com
Cc: linux-kernel@vger.kernel.org, John Johansen
 <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>
References: <202411221744.1a298e1e-lkp@intel.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <202411221744.1a298e1e-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav102.rs.sakura.ne.jp
X-Virus-Status: clean

That commit is not bad.

Kernel config says

  CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER=y
  # CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING is not set

which is a combination that cannot boot without doing one of choices listed below.

  Change CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING to y.

  Change CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER to n and
  install tomoyo-tools package and initialize on-disk policy.

  Modify built-in policy to include a complete set of on-disk policy.

On 2024/11/22 19:11, kernel test robot wrote:
> config: i386-randconfig-005-20241118

Please correct kernel config if random config selection hit this combination.


