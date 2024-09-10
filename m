Return-Path: <linux-kernel+bounces-323375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DCE973C6F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626A21F2212A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBF2196C7C;
	Tue, 10 Sep 2024 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QsB4DAkh"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35698193097
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725982838; cv=none; b=pvv53UtkmMtXS2krWHrwexR4hWYJ33Xp6XieVG5gN8dtJhrAGXt7PiwY0mVOL5tbqkjW3q5ZfQ22ZCYH2hdEQMHpLpqeDt6SX6M7+BpQNsn1j1+sY3f8vVpX2llnwkK32N83PHCh0XeZKPtJXEke1VTfDPJGMNMxxAV5rAS5D1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725982838; c=relaxed/simple;
	bh=yukHcBIAWNm/cWGG28DB6GX0X3tIMfhf1x+5Mw799Hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rA9EIX3S8FrP8PgtD/l5Tc60qxWsdnwVg0WE2yxkqU0VhuCfeK+ipM/9H7wKFYAnhCPGPQBqIEB2WYQFr/N8BlhPILtZOD6SU4DqH99HDJefteMoL+XVKLNhhM0ovkB1//NMGgWGEFOKhL8sSNhh4ZQZ4pfPWsYszY/zMHGt4OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QsB4DAkh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5C3BE20B9A71;
	Tue, 10 Sep 2024 08:40:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5C3BE20B9A71
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1725982836;
	bh=GEbbVepZzibwckyY9h9qBtxNkCQUB/KXA2P1eZb3ijI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QsB4DAkhN21l6NQyYiR0zRlaB+BywgD5ThY5jUDCytiqsvSF753EjloX4yVH9gPqr
	 F2S6jYloNa1HgxqzyG0AiH+elPVe4+dQnjxq8tdAPho3GbWGnjQAl4eQkb5EUmCWl6
	 FYqWPZCf3BZPYzVsuaXyQQqat8mvk/fd9tn1Ox8E=
From: Roman Kisel <romank@linux.microsoft.com>
To: oleg@redhat.com
Cc: akpm@linux-foundation.org,
	apais@microsoft.com,
	benhill@microsoft.com,
	ebiederm@xmission.com,
	linux-kernel@vger.kernel.org,
	romank@linux.microsoft.com,
	ssengar@microsoft.com,
	sunilmut@microsoft.com,
	torvalds@linux-foundation.org,
	vdso@hexbites.dev,
	workingjubilee@gmail.com
Subject: Re: [PATCH 1/1] ptrace: Get tracer PID without reliance on the proc FS
Date: Tue, 10 Sep 2024 08:40:35 -0700
Message-Id: <20240910154035.1204504-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909193725.GD14058@redhat.com>
References: <20240909193725.GD14058@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 09/09, Oleg wrote:

> On 09/07, Jubilee Young wrote:
> >
> > > Perhaps it makes sense to discuss the alternatives? Say, a process can have a
> > > please_insert_the_breakpoint_here() function implemented in asm which just does
> > > asm(ret).
> >
> > There's some merit in having the debuggers recognize this pattern, as that
> > then would save every language that wants to have this power available
> > the trouble of reimplementing it. But first debuggers must recognize it,
> > which would require teaching each of them, which can be... tedious.
> 
> Yet another thing in this discussion I can't understand... sorry, I tried.
> You do not need to teach, say, gdb to recognize this pattern. You can just do
> 
> 	$ gdb -ex 'b please_insert_the_breakpoint_here' ...
> 
> Nevermind, as I have already said you can safely ignore me. I still do not
> see any "real" use-case for breakpoint_if_debugging(), but I guess that is
> due to my ignorance and lack of imagination.

I've started this so let me butt in and take up the gaunlet.

Lambda's would be the most prominent example to me[1]. The toolchain
doesn't give them the user-accesible type and the name as it does for
the functions. Hence in the example above can't do the short'n'sweet
"b lol_wut", the debugger would complain about a function not found.
The right incantaion should be

"b main::{lambda()#1}::operator()() const" for gdb and 
"b main::$_0::operator()() const" for lldb,

that is visible in the disassembly with name demangling. I tried all "b"'s
options mentioned in the documentation to no avail. Likely the complexity
of some of the modern day user land code isn't handled gracefully by
the console debuggers that started out decades ago as debuggers for
the C code.

Sure, can fix that. Or the patch might be rejected because of reasons
being pretty noble from the maintainers' point of view. Say, lambdas
are ugly so why encourage people to use them?

D'oh, might go then write a Python extension that figures out the address
of the lambda. Can set the breakpoint by the line number yet that might
need to be updated when the source file changes, can put a hardware
breakpoint on the variable's address, yet slipping in the call to
"breakpoint_if_debugging" feels easier than using the commands in the
debugger.

Somewhat less painful wrt breakpoints are couroutines[2]. One would
think

"b switch_to_new_thread::awaitable::await_suspend"

should suffice but the right form incantation appears to be

"b switch_to_new_thread(std::jthread&)::awaitable::await_suspend(std::__n4861::coroutine_handle<void>)".

Fortunately, "br se --basename await_suspend" saves the day, still a
handful to type. Wait, what if there are _many_ "await_suspend" due to
function overloading, for example?

As for how real the examples are, the pattern of using lambdas/functors
is pretty common for libraries to define callbacks. Coroutines
are used to get some more perf due to less context switches - as we all
know - giving the semblance of a funcition call (I have had an experience
of working in a codebase that has that), makes coding huge state machines
more modular as I feel it.

That becomes very real if the customer is in pain and need to find the bug
asap. Using "breakpoint_if_debugging" vs figuring out in what nested namespace
the function is defined does have its merits. One can see that similar to
adding more printk's in the code. That notwithstanding, shipping the code with
"breakpoint_if_debugging" in the non-fatal path might be the last resort to
perhaps catch a race happening rarely if nothing else works out. Highly
debatable though in my opinion.

Similar should apply for Rust and Swift I believe as both use name mangling
to desugar code and they add hidden/automatic code paths as C++ does. The
sophisticated abstraction machinery, function name overloading, syntactic
sugar and the hidden code paths seem to make using the console debuggers
a bit more tedious I believe. It all started out with people not wanting to
care all the time about register allocation, and we got C instead of assembly :D
Machines are faster now, can parse more complex languages it appears and 
the compiler can do static reference checking, type inference and not needing
to have the declaration strictly before using it in the source file.
'Cause the times, they are a-changin' I guess.

> 
> Oleg.

Roman

[1]
// Compile with clang or gcc and "-std=c++11 -o bp ./bp.cpp".

// The stack in lldb/macOS:
//
// * thread #1, queue = 'com.apple.main-thread', stop reason = EXC_BREAKPOINT (code=1, subcode=0x100003f38)
//   * frame #0: 0x0000000100003f38 bp`std_breakpoint_if_debugging()
//     frame #1: 0x0000000100003f84 bp`main::$_0::operator()() const + 20
//     frame #2: 0x0000000100003f60 bp`main + 32

// The stack in gdb/Linux:
//
// Program received signal SIGTRAP, Trace/breakpoint trap.
// 0x00000000004101ac in std_breakpoint_if_debugging() ()
// (gdb) bt
// #0  0x00000000004101ac in std_breakpoint_if_debugging() ()
// #1  0x00000000004101c0 in main::{lambda()#1}::operator()() const ()
// #2  0x00000000004101f8 in main ()

void std_breakpoint_if_debugging() {
    #if defined(__i386__) || defined(__x86_64__)
        __asm__("int3");
    #elif defined(__aarch64__) || defined(__arm__)
        __builtin_trap();
    #elif defined(__powerpc__) || defined(__ppc__) || defined(__PPC__) || defined(__powerpc64__)
        __asm__(".long 0x7d821008"); // twge r2,r2? Wouldn't bet on that. Would you?
    #elif defined(__riscv)
        __asm__("ebreak");
    #else
        #error "Arch not supported"
    #endif
}

int main() {
    volatile int why_not;

    auto lol_wut = [&](){
        std_breakpoint_if_debugging();
        ++why_not;
    };

    lol_wut();
    return why_not;
}

[2, taken from https://en.cppreference.com/w/cpp/language/coroutines and adapted for illustrating the point]
// Compile with g++ -std=c++23 -fcoroutines -o corou ./corou.cpp

#include <coroutine>
#include <iostream>
#include <stdexcept>
#include <thread>

void std_breakpoint_if_debugging() {
#if defined(__i386__) || defined(__x86_64__)
    __asm__("int3");
#elif defined(__aarch64__) || defined(__arm__)
    __builtin_trap();
#elif defined(__powerpc__) || defined(__ppc__) || defined(__PPC__) || defined(__powerpc64__)
    __asm__(".long 0x7d821008"); // twge r2,r2? Wouldn't bet on that.
#elif defined(__riscv)
    __asm__("ebreak");
#else
    #error "Arch not supported"
#endif
}

auto switch_to_new_thread(std::jthread& out)
{
    struct awaitable
    {
        std::jthread* p_out;
        bool await_ready() { return false; }
        void await_suspend(std::coroutine_handle<> h)
        {
            std::jthread& out = *p_out;
            if (out.joinable())
                throw std::runtime_error("Output jthread parameter not empty");
            out = std::jthread([h] { h.resume(); });
            // Potential undefined behavior: accessing potentially destroyed *this
            // std::cout << "New thread ID: " << p_out->get_id() << '\n';
            std::cout << "New thread ID: " << out.get_id() << '\n'; // this is OK
            std_breakpoint_if_debugging();
        }
        void await_resume() {}
    };
    return awaitable{&out};
}
 
struct task
{
    struct promise_type
    {
        task get_return_object() { return {}; }
        std::suspend_never initial_suspend() { return {}; }
        std::suspend_never final_suspend() noexcept { return {}; }
        void return_void() {}
        void unhandled_exception() {}
    };
};
 
task resuming_on_new_thread(std::jthread& out)
{
    std::cout << "Coroutine started on thread: " << std::this_thread::get_id() << '\n';
    co_await switch_to_new_thread(out);
    // awaiter destroyed here
    std::cout << "Coroutine resumed on thread: " << std::this_thread::get_id() << '\n';
}

int main()
{
    std::jthread out;
    resuming_on_new_thread(out);
}



--
Thank you,
Roman

