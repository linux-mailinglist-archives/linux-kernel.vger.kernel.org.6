Return-Path: <linux-kernel+bounces-553712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B58A58DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D8816A8C4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BD72236F7;
	Mon, 10 Mar 2025 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cyaTK674"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DA9223337
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741594857; cv=none; b=SgM2h4TBNARBZvi1PDpQ8TVZZoAa9ifAw8mDZ7hQSiU6dTQleKYwVYEFugdnAJQsZk0LI/fRP61hk9rp83t7oIK+4zU15KKAiRE9sk/g/j2q5J+xKIjvFo98iENWbXLBpNNQ7CjUUQ+bX7miPYwxWlaYHAH04O93sJP89mXT8jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741594857; c=relaxed/simple;
	bh=a3XRq5SZMIxfZ+2Mgp5d2cHVY8T95QU6b1B4CIW7pak=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=K8tpapKSkdiBG+a3X1XyUp/tCXS5IhWTUR2Qi9RVHpPZkuSlo4yR20YhbQCzdg2cLBM5ewNe4js/L5IIIZCsKHK1qYI7Kb9IspVZhwk175Y5QgQpMDM5OiqSA8TszZi02awNU6xcXzbLzl930xPHpF8AqzRRHEhxL/+k67Vj2qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cyaTK674; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43bc63876f1so33377105e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 01:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741594853; x=1742199653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/IRa+YB+4QLff7q5apAvMehk6zSiN1B98VZ8cSYC1R0=;
        b=cyaTK6740rbt95+uQsX5kzvSWPBI4uXp5z/vXsXqHXMs73rJSBuPA5DgvyA40T43IW
         7RS1D16MMYdk1NFt747ltEZwmyfGQ73SESIwQ0QfjbaiLF4lh5abAAYnNJeiqNiVFMzM
         Ncv7MEIdpD14lX12p/6/msmtYfw1YnSfrXvgydgxu6tm4ojjG5qFySXpTvGUiuJFHz5M
         xL/HSMAC3yEIPfExh2eXv7evcd1LrBys36ArdiPD1GHWEdUVtStDyh2WtTBUacvvgg8h
         DazycAcTQKU0Hn/7kxmGSr2JGP3SZ0DXzF3pT8m53MgHWiUVnM05x7yalcPCOUNNv7eh
         IGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741594853; x=1742199653;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/IRa+YB+4QLff7q5apAvMehk6zSiN1B98VZ8cSYC1R0=;
        b=SrE8mGQjoIh8D+NjO6wB7zkX02zdT5OX+6zSdbk5wRjErWLh94ZXpVzDqy77/0Ditk
         /kY7KGRiPaBNw0ZnDrPUEi7vUG8v+WN15aHXXOma8MStZ5Stng/O1QQ9ZujutMN6M/qA
         oxAJlRt2/qUvfMW14RYg8CqWOdyG9j8XqvJ8Ej0eIuzBCxuH7NxBpg6yQun2vGTmGenc
         toYJd5ZfGm3P/3XXU4bkLH5kCTZNN5t98lOdWmBZ3WdxQPtkS+EF4JsZ6bwWSykOhAO+
         e2+0jLeBuND4Qa24Pza7urorP/V/ym9n+fuINX2tBNqdX4fwjRkNk59NuQ2/5vPQbBjB
         ceHg==
X-Forwarded-Encrypted: i=1; AJvYcCU7HH0yt6qj9FZ8vTaBPbjy+TIiIncn1B41Y6wa68Sb/8aw+WEB9v0VJiMkt0F9eAMoHY6WZMHVa6MzwzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBSqIEZ86+Fg6gcRumtox/KCIUu7EROBFDUd4BoRRKSvNAUZdA
	JchBGyhkqd7L6kiFogegvgEZbTVh0uJzPcguxWVXgqCEKJyY0XrvF/F6l5Cc/iE=
X-Gm-Gg: ASbGnctjFHr0CnrYxefs4GN+c0OpuONzrsahSLmeYSU45IEZSJ4O9qM274wCLygqEFp
	5fpGJs+pao46WMT1XJ+MV6ckSH9ZwlrB/zM/8nMQms2Mc9Yg3/cgNreesbCN8aHT3BBieyq1KO+
	aeD6VYBcVmVxlEQIOQZwvyn9/U+0NASbWNk86P1LpJQ/nEB/KpWyeE9w1XkoFKI8/MOoNfPminB
	xUZsChHNd/ca/OjoX9cVKDFFV/PX/jE9mzw52NAQ2g2r4sXBGzcpq5dGJFtBHiDrno1O0UODMd6
	AevHkfohA3ivyB0sGxZNBzyYiO2N7X1rUrjStKN9G0ewEaXigw==
X-Google-Smtp-Source: AGHT+IEGATgu5VbdS6kbtg3c6tfuRZz15xP7b2oCeJs8qye1D0o8hlDPBidbACz+FOSKn4FK+JvF+A==
X-Received: by 2002:a5d:47a2:0:b0:391:12a5:3c95 with SMTP id ffacd0b85a97d-39132d6b98dmr7210587f8f.22.1741594852971;
        Mon, 10 Mar 2025 01:20:52 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912bfba87csm14444368f8f.17.2025.03.10.01.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 01:20:52 -0700 (PDT)
Date: Mon, 10 Mar 2025 11:20:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Casey Schaufler <casey@schaufler-ca.com>,
	paul@paul-moore.com, eparis@redhat.com,
	linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, jmorris@namei.org,
	serge@hallyn.com, keescook@chromium.org,
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH v2 6/6] Audit: Add record for multiple object contexts
Message-ID: <f57dc6f4-cc46-4a58-9525-1dfda105ea59@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307183701.16970-7-casey@schaufler-ca.com>

Hi Casey,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Casey-Schaufler/Audit-Create-audit_stamp-structure/20250308-024950
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next
patch link:    https://lore.kernel.org/r/20250307183701.16970-7-casey%40schaufler-ca.com
patch subject: [PATCH v2 6/6] Audit: Add record for multiple object contexts
config: powerpc64-randconfig-r073-20250309 (https://download.01.org/0day-ci/archive/20250310/202503100802.Dqju4qc5-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202503100802.Dqju4qc5-lkp@intel.com/

smatch warnings:
kernel/auditsc.c:1753 audit_log_exit() warn: if statement not indented

vim +1753 kernel/auditsc.c

e54dc2431d740a Amy Griffis        2007-03-29  1749  	for (aux = context->aux_pids; aux; aux = aux->next) {
e54dc2431d740a Amy Griffis        2007-03-29  1750  		struct audit_aux_data_pids *axs = (void *)aux;
e54dc2431d740a Amy Griffis        2007-03-29  1751  
e54dc2431d740a Amy Griffis        2007-03-29  1752  		for (i = 0; i < axs->pid_count; i++)
e54dc2431d740a Amy Griffis        2007-03-29 @1753  			if (audit_log_pid_context(context, axs->target_pid[i],
c2a7780efe37d0 Eric Paris         2008-01-07  1754  						  axs->target_auid[i],
c2a7780efe37d0 Eric Paris         2008-01-07  1755  						  axs->target_uid[i],
4746ec5b01ed07 Eric Paris         2008-01-08  1756  						  axs->target_sessionid[i],
13d826e564e2cc Casey Schaufler    2024-10-09  1757  						  &axs->target_ref[i],
c2a7780efe37d0 Eric Paris         2008-01-07  1758  						  axs->target_comm[i]))
e54dc2431d740a Amy Griffis        2007-03-29  1759  			call_panic = 1;

This should be indented another tab.

a5cb013da773a6 Al Viro            2007-03-20  1760  	}
a5cb013da773a6 Al Viro            2007-03-20  1761  
e54dc2431d740a Amy Griffis        2007-03-29  1762  	if (context->target_pid &&
e54dc2431d740a Amy Griffis        2007-03-29  1763  	    audit_log_pid_context(context, context->target_pid,
c2a7780efe37d0 Eric Paris         2008-01-07  1764  				  context->target_auid, context->target_uid,
4746ec5b01ed07 Eric Paris         2008-01-08  1765  				  context->target_sessionid,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


