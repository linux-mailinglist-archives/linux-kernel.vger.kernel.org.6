Return-Path: <linux-kernel+bounces-181063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A458C76FF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CFE3282B4D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA4A146A86;
	Thu, 16 May 2024 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TvfZD0bY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C114658E
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864405; cv=none; b=VT8uxe23rcSiareVSh36Uvzc079m+hMWxTQK9jiHMx7cdvgScMTlJMOqr2l/LdIpNbc9KOqaotxCg0oSi7n4MFnPil5wGUlZNQgeXZoUnC46/vunH1Xd2pwpbcmLKaJBxO/eeuG4jXzvleQ07JxOcbGF0cA7dS+nZywmwjPf2dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864405; c=relaxed/simple;
	bh=dJ0NAdMJFothU+MVSsRxsK17yyT8UnYRq+CRtxkPs2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZrOITpzwC8lLhordOhYaaXFqOxX+JLBESVZVb7ObBT+24EUD/VHiyTyMSuLo4vBHAzCdFDA3Itv13UMJXfZOeePsvs6AzOZpWcxTD3KuZpgnJZBVXT4DnWAtpjdyNyIRkpNcKwO1RrfK3t4yMbhgXLmtZY08PvPKPbHx8xNmL+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TvfZD0bY; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715864402; x=1747400402;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dJ0NAdMJFothU+MVSsRxsK17yyT8UnYRq+CRtxkPs2Q=;
  b=TvfZD0bYi7JbQh1VCPQS9QrlZd8PBkWHxf5WgyKLD8E7pckOGS4ilJcV
   JymxEE1uCGGb79sSPigpI3ZbQ9yz3twjJ+p8m9xDQ234LxDmMq8q3myzw
   AVdZQ8P1GaPk1wgPnz2cwhdpAN8vChp3rgmzwTi7UirgnBd7RH8/6ku2d
   Zj4DqtH1dqtfLMUVJ11MY4HdxoQxwW5YBJ1YjuHKOgsouMImmK5EPHqwq
   9RDb9pUo14szSxtlrpAaAG8T2hgLbl0rBFoEVncsb5aZlq1KCrVlA0I04
   01lpO4wAsO2fRvjwvotm/X2ctHbhbsKwqDkx1DK+r6kX6yHl6PdY5jDp5
   A==;
X-CSE-ConnectionGUID: wE/WN9VaTY61pF3kz16Psg==
X-CSE-MsgGUID: E0lq0NVAQcmZIXtrPLzQpQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="23108454"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="23108454"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 06:00:01 -0700
X-CSE-ConnectionGUID: //zX3EGARB6EP7s99DIsfg==
X-CSE-MsgGUID: jmTz8BM/Q7q82vALcJxXUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="31971828"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 16 May 2024 06:00:00 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7aiC-000EFP-37;
	Thu, 16 May 2024 12:59:56 +0000
Date: Thu, 16 May 2024 20:59:02 +0800
From: kernel test robot <lkp@intel.com>
To: Borislav Petkov <bp@suse.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [tip:x86/urgent 1/1] arch/x86/boot/printf.c:257:3: warning:
 unannotated fall-through between switch labels
Message-ID: <202405162054.ryP73vy1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
head:   dd0716c2b87792ebea30864e7ad1df461d4c1525
commit: dd0716c2b87792ebea30864e7ad1df461d4c1525 [1/1] x86/boot: Add a fallthrough annotation
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20240516/202405162054.ryP73vy1-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240516/202405162054.ryP73vy1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405162054.ryP73vy1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/boot/printf.c:257:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
     257 |                 case 'u':
         |                 ^
   arch/x86/boot/printf.c:257:3: note: insert 'break;' to avoid fall-through
     257 |                 case 'u':
         |                 ^
         |                 break; 
   1 warning generated.


vim +257 arch/x86/boot/printf.c

1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  112  
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  113  int vsprintf(char *buf, const char *fmt, va_list args)
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  114  {
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  115  	int len;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  116  	unsigned long num;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  117  	int i, base;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  118  	char *str;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  119  	const char *s;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  120  
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  121  	int flags;		/* flags to number() */
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  122  
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  123  	int field_width;	/* width of output field */
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  124  	int precision;		/* min. # of digits for integers; max
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  125  				   number of chars for from string */
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  126  	int qualifier;		/* 'h', 'l', or 'L' for integer fields */
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  127  
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  128  	for (str = buf; *fmt; ++fmt) {
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  129  		if (*fmt != '%') {
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  130  			*str++ = *fmt;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  131  			continue;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  132  		}
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  133  
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  134  		/* process flags */
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  135  		flags = 0;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  136  	      repeat:
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  137  		++fmt;		/* this also skips first '%' */
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  138  		switch (*fmt) {
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  139  		case '-':
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  140  			flags |= LEFT;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  141  			goto repeat;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  142  		case '+':
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  143  			flags |= PLUS;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  144  			goto repeat;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  145  		case ' ':
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  146  			flags |= SPACE;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  147  			goto repeat;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  148  		case '#':
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  149  			flags |= SPECIAL;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  150  			goto repeat;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  151  		case '0':
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  152  			flags |= ZEROPAD;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  153  			goto repeat;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  154  		}
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  155  
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  156  		/* get field width */
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  157  		field_width = -1;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  158  		if (isdigit(*fmt))
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  159  			field_width = skip_atoi(&fmt);
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  160  		else if (*fmt == '*') {
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  161  			++fmt;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  162  			/* it's the next argument */
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  163  			field_width = va_arg(args, int);
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  164  			if (field_width < 0) {
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  165  				field_width = -field_width;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  166  				flags |= LEFT;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  167  			}
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  168  		}
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  169  
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  170  		/* get the precision */
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  171  		precision = -1;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  172  		if (*fmt == '.') {
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  173  			++fmt;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  174  			if (isdigit(*fmt))
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  175  				precision = skip_atoi(&fmt);
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  176  			else if (*fmt == '*') {
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  177  				++fmt;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  178  				/* it's the next argument */
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  179  				precision = va_arg(args, int);
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  180  			}
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  181  			if (precision < 0)
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  182  				precision = 0;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  183  		}
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  184  
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  185  		/* get the conversion qualifier */
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  186  		qualifier = -1;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  187  		if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L') {
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  188  			qualifier = *fmt;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  189  			++fmt;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  190  		}
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  191  
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  192  		/* default base */
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  193  		base = 10;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  194  
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  195  		switch (*fmt) {
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  196  		case 'c':
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  197  			if (!(flags & LEFT))
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  198  				while (--field_width > 0)
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  199  					*str++ = ' ';
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  200  			*str++ = (unsigned char)va_arg(args, int);
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  201  			while (--field_width > 0)
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  202  				*str++ = ' ';
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  203  			continue;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  204  
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  205  		case 's':
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  206  			s = va_arg(args, char *);
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  207  			len = strnlen(s, precision);
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  208  
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  209  			if (!(flags & LEFT))
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  210  				while (len < field_width--)
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  211  					*str++ = ' ';
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  212  			for (i = 0; i < len; ++i)
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  213  				*str++ = *s++;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  214  			while (len < field_width--)
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  215  				*str++ = ' ';
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  216  			continue;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  217  
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  218  		case 'p':
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  219  			if (field_width == -1) {
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  220  				field_width = 2 * sizeof(void *);
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  221  				flags |= ZEROPAD;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  222  			}
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  223  			str = number(str,
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  224  				     (unsigned long)va_arg(args, void *), 16,
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  225  				     field_width, precision, flags);
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  226  			continue;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  227  
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  228  		case 'n':
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  229  			if (qualifier == 'l') {
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  230  				long *ip = va_arg(args, long *);
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  231  				*ip = (str - buf);
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  232  			} else {
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  233  				int *ip = va_arg(args, int *);
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  234  				*ip = (str - buf);
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  235  			}
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  236  			continue;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  237  
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  238  		case '%':
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  239  			*str++ = '%';
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  240  			continue;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  241  
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  242  			/* integer number formats - set up the flags and "break" */
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  243  		case 'o':
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  244  			base = 8;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  245  			break;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  246  
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  247  		case 'x':
9b706aee7d92d6 arch/x86/boot/printf.c  Denys Vlasenko  2008-02-09  248  			flags |= SMALL;
dd0716c2b87792 arch/x86/boot/printf.c  Borislav Petkov 2024-05-16  249  			fallthrough;
9b706aee7d92d6 arch/x86/boot/printf.c  Denys Vlasenko  2008-02-09  250  		case 'X':
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  251  			base = 16;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  252  			break;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  253  
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  254  		case 'd':
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  255  		case 'i':
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  256  			flags |= SIGN;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11 @257  		case 'u':
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  258  			break;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  259  
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  260  		default:
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  261  			*str++ = '%';
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  262  			if (*fmt)
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  263  				*str++ = *fmt;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  264  			else
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  265  				--fmt;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  266  			continue;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  267  		}
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  268  		if (qualifier == 'l')
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  269  			num = va_arg(args, unsigned long);
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  270  		else if (qualifier == 'h') {
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  271  			num = (unsigned short)va_arg(args, int);
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  272  			if (flags & SIGN)
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  273  				num = (short)num;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  274  		} else if (flags & SIGN)
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  275  			num = va_arg(args, int);
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  276  		else
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  277  			num = va_arg(args, unsigned int);
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  278  		str = number(str, num, base, field_width, precision, flags);
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  279  	}
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  280  	*str = '\0';
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  281  	return str - buf;
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  282  }
1543610ad79ac4 arch/i386/boot/printf.c H. Peter Anvin  2007-07-11  283  

:::::: The code at line 257 was first introduced by commit
:::::: 1543610ad79ac4cc61c26f8a29c84e4229faa9a3 Console-writing code for the new x86 setup code

:::::: TO: H. Peter Anvin <hpa@zytor.com>
:::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

