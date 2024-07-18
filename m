Return-Path: <linux-kernel+bounces-255983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4A7934765
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5C65B20CB2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 05:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6E546426;
	Thu, 18 Jul 2024 05:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQRm3gFh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7E94502E;
	Thu, 18 Jul 2024 05:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721279495; cv=none; b=ToEYAma93VQ1vuk56VHv+35Gi9lhxoyITcWc1LYbHEOTWDoatvaGoVNBnhNZ0sgd5anvvaiPWrk1DbTnij9UjJ723AAcEzewn6jCJfgjIs9a7z4pTZi/Xu0EMRFzm6c+3xn050gYOIYBlM3EKVvd7hLPIvnfC1vgLtyeIUdZai4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721279495; c=relaxed/simple;
	bh=xv6q3glHu3xxJGPyX88aCfgjX9TfVcPLyLtjMkq7GwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rokq2083ZTLHreYu+H7gMR2kYxkz9LNDzj/7BIPLKIVtEmB6kHFoTtJR7EqYY4Si66Gdf1qRTe9Wdz8xGnL9V8y47Mv0RfzN4zHcMcOKg04Q8gnHx/c7TnsnrGj639qgZEGnZZYWQeuZVwnmYTqsnxJ85BpdXxb1Nf1CYUOvAMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQRm3gFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98314C116B1;
	Thu, 18 Jul 2024 05:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721279495;
	bh=xv6q3glHu3xxJGPyX88aCfgjX9TfVcPLyLtjMkq7GwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQRm3gFhRV0P3EEJvCgkmQD01JsWdg7vrk3SGc/vRy6K+W8UCDYG/uJhjbOKQ8q93
	 UTrnmcLPSNKEFRordN6TJ4x28TAXp06Ls4mTXK6uaxf4KG3SkhzxabDPHSnlG3BYF1
	 xdUAzMoBr6j91KjqRkm6Xco9sQI+lS/XRy12GnlmRqXK12u9ztHG/KB6x3z4f+RS75
	 iqYTbrnrTpsW4GaVqNGr1v4kphIi56J8QichOicOLusp2QoQ5APnPv8EuO3va86jV+
	 Yx2WcAjsWEJp/tonay5MjNkrZf68ticJZ82DpiGtFEjtZSbFfefJaR/8E43amwOVos
	 V4lqqfwPdhHpQ==
Date: Wed, 17 Jul 2024 22:11:33 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	irogers@google.com, segher@kernel.crashing.org,
	christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	akanksha@linux.ibm.com, maddy@linux.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH V7 15/18] tools/perf: Add support to find global register
 variables using find_data_type_global_reg
Message-ID: <ZpikBQdVxVpy5ETw@google.com>
References: <20240713165529.59298-1-atrajeev@linux.vnet.ibm.com>
 <20240713165529.59298-16-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240713165529.59298-16-atrajeev@linux.vnet.ibm.com>

Hello,

On Sat, Jul 13, 2024 at 10:25:26PM +0530, Athira Rajeev wrote:
> There are cases where define a global register variable and associate it
> with a specified register. Example, in powerpc, two registers are
> defined to represent variable:
> 1. r13: represents local_paca
> register struct paca_struct *local_paca asm("r13");
> 
> 2. r1: represents stack_pointer
> register void *__stack_pointer asm("r1");
> 
> These regs are present in dwarf debug as DW_OP_reg as part of variables
> in the cu_die (compile unit). These are not present in die search done
> in the list of nested scopes since these are global register variables.
> 
> Example for local_paca represented by r13:
> 
> <<>>
>  <1><18dc6b4>: Abbrev Number: 128 (DW_TAG_variable)
>     <18dc6b6>   DW_AT_name        : (indirect string, offset: 0x3861): local_paca
>     <18dc6ba>   DW_AT_decl_file   : 48
>     <18dc6bb>   DW_AT_decl_line   : 36
>     <18dc6bc>   DW_AT_decl_column : 30
>     <18dc6bd>   DW_AT_type        : <0x18dc6c3>
>     <18dc6c1>   DW_AT_external    : 1
>     <18dc6c1>   DW_AT_location    : 1 byte block: 5d    (DW_OP_reg13 (r13))
> 
>  <1><18dc6c3>: Abbrev Number: 3 (DW_TAG_pointer_type)
>     <18dc6c4>   DW_AT_byte_size   : 8
>     <18dc6c4>   DW_AT_type        : <0x18dc353>
> 
> Where  DW_AT_type : <0x18dc6c3> further points to :
> 
>  <1><18dc6c3>: Abbrev Number: 3 (DW_TAG_pointer_type)
>     <18dc6c4>   DW_AT_byte_size   : 8
>     <18dc6c4>   DW_AT_type        : <0x18dc353>
> 
> which belongs to:
> 
>  <1><18dc353>: Abbrev Number: 67 (DW_TAG_structure_type)
>     <18dc354>   DW_AT_name        : (indirect string, offset: 0x56cd): paca_struct
>     <18dc358>   DW_AT_byte_size   : 2944
>     <18dc35a>   DW_AT_alignment   : 128
>     <18dc35b>   DW_AT_decl_file   : 48
>     <18dc35c>   DW_AT_decl_line   : 61
>     <18dc35d>   DW_AT_decl_column : 8
>     <18dc35d>   DW_AT_sibling     : <0x18dc6b4>
> <<>>
> 
> Similar is case with "r1".
> 
> <<>>
>  <1><18dd772>: Abbrev Number: 129 (DW_TAG_variable)
>     <18dd774>   DW_AT_name        : (indirect string, offset: 0x11ba): current_stack_pointer
>     <18dd778>   DW_AT_decl_file   : 51
>     <18dd779>   DW_AT_decl_line   : 1468
>     <18dd77b>   DW_AT_decl_column : 24
>     <18dd77c>   DW_AT_type        : <0x18da5cd>
>     <18dd780>   DW_AT_external    : 1
>     <18dd780>   DW_AT_location    : 1 byte block: 51    (DW_OP_reg1 (r1))
> 
>  where 18da5cd is:
> 
>  <1><18da5cd>: Abbrev Number: 47 (DW_TAG_base_type)
>     <18da5ce>   DW_AT_byte_size   : 8
>     <18da5cf>   DW_AT_encoding    : 7   (unsigned)
>     <18da5d0>   DW_AT_name        : (indirect string, offset: 0x55c7): long unsigned int
> <<>>
> 
> To identify data type for these two special cases, iterate over
> variables in the CU die (Compile Unit) and match it with the register.
> If the variable is a base type, ie die_get_real_type will return NULL

I'm not sure why die_get_real_type() returned NULL.  The variable has
the type attribute and the function run the loop only if the type is
either const, restrict, volatile, shared or typedef.  So I think it
should return the base_type DIE.


> here, set offset to zero. With the changes, data type for "paca_struct"
> and "long unsigned int" for r1 is identified.
> 
> Snippet from ./perf report -s type,type_off
> 
>     12.85%  long unsigned int  long unsigned int +0 (no field)
>      4.68%  struct paca_struct  struct paca_struct +2312 (__current)
>      4.57%  struct paca_struct  struct paca_struct +2354 (irq_soft_mask)
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/util/annotate-data.c      | 42 ++++++++++++++++++++++++++++
>  tools/perf/util/annotate.c           |  8 ++++++
>  tools/perf/util/annotate.h           |  1 +
>  tools/perf/util/include/dwarf-regs.h |  1 +
>  4 files changed, 52 insertions(+)
> 
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 734acdd8c4b7..a5b4429ede57 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -1170,6 +1170,42 @@ static int find_data_type_block(struct data_loc_info *dloc,
>  	return ret;
>  }
>  
> +/*
> + * Handle cases where define a global register variable and
> + * associate it with a specified register. These regs are
> + * present in dwarf debug as DW_OP_reg as part of variables
> + * in the cu_die (compile unit). Iterate over variables in the
> + * cu_die and match with reg to identify data type die.
> + */
> +static int find_data_type_global_reg(struct data_loc_info *dloc, int reg, Dwarf_Die *cu_die,
> +		Dwarf_Die *type_die)
> +{
> +	Dwarf_Die vr_die;
> +	int ret = -1;
> +	struct die_var_type *var_types, *vt = NULL;
> +
> +	die_collect_vars(cu_die, &vt);
> +	for (var_types = vt; var_types; var_types = var_types->next) {
> +		if (var_types->reg != reg)
> +			continue;
> +		if (dwarf_offdie(dloc->di->dbg, var_types->die_off, &vr_die)) {
> +			if (die_get_real_type(&vr_die, type_die) == NULL) {

Ok, I think I know the reason.  You don't need to call die_get_real_type()
here as var_types already has the type, not the variable.  Usually we
want a pointer type for a variable.  For the final result, you want the
target type of the pointer though.


> +				dloc->type_offset = 0;
> +				dwarf_offdie(dloc->di->dbg, var_types->die_off, type_die);
> +			}
> +			pr_debug_type_name(type_die, TSR_KIND_TYPE);
> +			ret = 0;
> +			pr_debug_dtp("found by CU for %s (die:%#lx)\n",

I think it's better to say found by global register %d.


> +					dwarf_diename(type_die), (long)dwarf_dieoffset(type_die));
> +			break;
> +		}
> +	}
> +
> +	delete_var_types(vt);
> +
> +	return ret;
> +}
> +
>  /* The result will be saved in @type_die */
>  static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
>  {
> @@ -1217,6 +1253,12 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
>  	pr_debug_dtp("CU for %s (die:%#lx)\n",
>  		     dwarf_diename(&cu_die), (long)dwarf_dieoffset(&cu_die));
>  
> +	if (loc->reg_type == DWARF_REG_GLOBAL) {
> +		ret = find_data_type_global_reg(dloc, reg, &cu_die, type_die);
> +		if (!ret)
> +			goto out;
> +	}
> +
>  	if (reg == DWARF_REG_PC) {
>  		if (get_global_var_type(&cu_die, dloc, dloc->ip, dloc->var_addr,
>  					&offset, type_die)) {
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index ce99db291c5e..8db2f32700aa 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2425,6 +2425,14 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
>  			op_loc->reg1 = DWARF_REG_PC;
>  		}
>  
> +		/* Global reg variable 13 and 1
> +		 * assign to DWARF_REG_GLOBAL
> +		 */
> +		if (arch__is(arch, "powerpc")) {
> +			if ((op_loc->reg1 == 13) || (op_loc->reg1 == 1))
> +				op_loc->reg_type = DWARF_REG_GLOBAL;
> +		}
> +
>  		mem_type = find_data_type(&dloc);
>  
>  		if (mem_type == NULL && is_stack_canary(arch, op_loc)) {
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 9ba772f46270..ad69842a8ebc 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -475,6 +475,7 @@ struct annotated_op_loc {
>  	bool mem_ref;
>  	bool multi_regs;
>  	bool imm;
> +	int reg_type;

Just bool global_reg would be enough unless you plan to add more
register types.

Thanks,
Namhyung


>  };
>  
>  enum annotated_insn_ops {
> diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
> index 75b28dcc8317..a5e8e9498683 100644
> --- a/tools/perf/util/include/dwarf-regs.h
> +++ b/tools/perf/util/include/dwarf-regs.h
> @@ -5,6 +5,7 @@
>  
>  #define DWARF_REG_PC  0xd3af9c /* random number */
>  #define DWARF_REG_FB  0xd3affb /* random number */
> +#define DWARF_REG_GLOBAL 0xd3affc /* random number */
>  
>  #ifdef HAVE_DWARF_SUPPORT
>  const char *get_arch_regstr(unsigned int n);
> -- 
> 2.43.0
> 

